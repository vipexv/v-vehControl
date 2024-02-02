RegisterCommand("vehmenu", function()
    -- ToggleNuiFrame(true)
    SendCurrentVehicleDataToNui()

    Debug("[command:show-nui] ToggleNuiFrame called and set to true.")
end, false)

RegisterCommand("car", function(source, args, rawCommand)
    local carModel = args[1]

    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local pedHeading = GetEntityHeading(ped)

    RequestModel(carModel)

    while not HasModelLoaded(carModel) do Wait(0) end

    local veh = CreateVehicle(carModel, pedCoords.x, pedCoords.y, pedCoords.z, pedHeading, true, false)

    SetPedIntoVehicle(ped, veh, -1)
end, false)


RegisterCommand("dv", function(source, args, rawCommand)
    local ped = PlayerPedId()
    local currVeh = GetVehiclePedIsIn(ped, false)

    SetEntityAsNoLongerNeeded(currVeh)
    SetModelAsNoLongerNeeded(currVeh)

    DeleteEntity(currVeh)
end, false)
