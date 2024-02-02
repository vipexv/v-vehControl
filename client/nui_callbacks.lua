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
