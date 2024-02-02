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
end)

RegisterNuiCallback("vehmenu:toggledoor", function(doorIndex, _cb)
    Debug(doorIndex)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if GetVehicleDoorAngleRatio(veh, doorIndex) > 0.0 then
        SetVehicleDoorShut(veh, doorIndex, false)
    else
        SetVehicleDoorOpen(veh, doorIndex, false, false)
    end
end)

RegisterNuiCallback("vehmenu:togglewindow", function(windowIndex, _cb)
    Debug(windowIndex)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)

    if IsVehicleWindowIntact(veh, windowIndex) then
        RollDownWindow(veh, windowIndex)
    else
        RollUpWindow(veh, windowIndex)
    end
end)

---comment
---@param data VehicleOption
RegisterNuiCallback("vehmenu:toggleoption", function(data, cb)
    local option = data.option
    local ped = PlayerPedId()
    local currVeh = GetVehiclePedIsIn(ped, false)

    if option == "engine" then
        local engineRunning = GetIsVehicleEngineRunning(currVeh)
        SetVehicleEngineOn(currVeh, not engineRunning, false, true)
        Debug("Engine set to: ", not engineRunning)
        return
    end

    if option == "rightblinker" then
        local lightsState = GetVehicleIndicatorLights(currVeh)
        local lightsStateBool = lightsState ~= 2 and lightsState ~= 3
        Debug(lightsStateBool)

        SetVehicleIndicatorLights(currVeh, 0, lightsStateBool)
        return
    end

    if option == "leftblinker" then
        local lightsState = GetVehicleIndicatorLights(currVeh)
        local lightsStateBool = lightsState ~= 1 and lightsState ~= 3
        Debug(lightsStateBool)

        SetVehicleIndicatorLights(currVeh, 1, lightsStateBool)
        return
    end
end)
