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
