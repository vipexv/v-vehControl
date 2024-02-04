RegisterNuiCallback('hideFrame', function(_, cb)
    ToggleNuiFrame(false)
    Debug('[nuicb:hideFrame] called')
    cb({})
end)

RegisterNuiCallback("vehmenu:setseat", function(index, _cb)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    -- JS index starts at 0.
    local seatIndex = index - 1
    if not IsVehicleSeatFree(veh, seatIndex) then
        return Debug("Veh seat isn't free.")
    end

    SetPedIntoVehicle(ped, veh, seatIndex)
    SendCurrentVehicleDataToNui(true)
end)

RegisterNuiCallback("vehmenu:toggledoor", function(doorIndex, _cb)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if GetVehicleDoorAngleRatio(veh, doorIndex) > 0.0 then
        SetVehicleDoorShut(veh, doorIndex, false)
    else
        SetVehicleDoorOpen(veh, doorIndex, false, false)
    end

    SetTimeout(650, function()
        SendCurrentVehicleDataToNui(true)
    end)
end)

RegisterNuiCallback("vehmenu:togglefocus", function(bool, cb)
    SetNuiFocus(true, bool)
    cb({})
end)

RegisterNuiCallback("vehmenu:togglewindow", function(windowIndex, _cb)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)

    if IsVehicleWindowIntact(veh, windowIndex) then
        RollDownWindow(veh, windowIndex)
    else
        RollUpWindow(veh, windowIndex)
    end
    SendCurrentVehicleDataToNui(true)
end)

---@param data VehicleOption
RegisterNuiCallback("vehmenu:toggleoption", function(data, cb)
    local option = data.option
    local ped = PlayerPedId()
    local currVeh = GetVehiclePedIsIn(ped, false)
    local delay = 0

    if option == "engine" then
        local engineRunning = GetIsVehicleEngineRunning(currVeh)
        SetVehicleEngineOn(currVeh, not engineRunning, false, true)
        Debug("Engine set to: ", not engineRunning)
        -- The engine takes a bit to start up, updating state after that.
        delay = 1000
    end

    if option == "right_blinker" then
        local lightsState = GetVehicleIndicatorLights(currVeh)
        local lightsStateBool = lightsState ~= 2 and lightsState ~= 3
        SetVehicleIndicatorLights(currVeh, 0, lightsStateBool)
    end

    if option == "left_blinker" then
        local lightsState = GetVehicleIndicatorLights(currVeh)
        local lightsStateBool = lightsState ~= 1 and lightsState ~= 3
        SetVehicleIndicatorLights(currVeh, 1, lightsStateBool)
    end

    if option == "alert" then
        local lightsState = GetVehicleIndicatorLights(currVeh)

        if lightsState ~= 3 then
            SetVehicleIndicatorLights(currVeh, 0, true)
            SetVehicleIndicatorLights(currVeh, 1, true)
        else
            SetVehicleIndicatorLights(currVeh, 0, false)
            SetVehicleIndicatorLights(currVeh, 1, false)
        end
    end

    if option == "interior_light" then
        local currState = IsVehicleInteriorLightOn(currVeh)
        SetVehicleInteriorlight(currVeh, not currState)
    end

    if delay > 0 then
        SetTimeout(delay, function()
            SendCurrentVehicleDataToNui(true)
        end)
        return
    end

    SendCurrentVehicleDataToNui(true)
end)
