RegisterCommand(Config.CommandName, function()
    SendCurrentVehicleDataToNui()

    Debug("[command:show-nui] ToggleNuiFrame called and set to true.")
end, false)

-- RegisterCommand("car", function(source, args, rawCommand)
--     local carModel = args[1]

--     local ped = PlayerPedId()
--     local pedCoords = GetEntityCoords(ped)
--     local pedHeading = GetEntityHeading(ped)
--     local isInVeh = IsPedInAnyVehicle(ped, false)

--     if isInVeh then
--         local currVeh = GetVehiclePedIsIn(ped, false)

--         SetEntityAsNoLongerNeeded(currVeh)
--         SetModelAsNoLongerNeeded(currVeh)

--         DeleteEntity(currVeh)
--     end

--     RequestModel(carModel)

--     while not HasModelLoaded(carModel) do Wait(0) end

--     local veh = CreateVehicle(carModel, pedCoords.x, pedCoords.y, pedCoords.z, pedHeading, true, false)

--     SetPedIntoVehicle(ped, veh, -1)
-- end, false)


-- RegisterCommand("dv", function(source, args, rawCommand)
--     local ped = PlayerPedId()
--     local currVeh = GetVehiclePedIsIn(ped, false)

--     SetEntityAsNoLongerNeeded(currVeh)
--     SetModelAsNoLongerNeeded(currVeh)

--     DeleteEntity(currVeh)
-- end, false)


-- RegisterCommand("door", function(source, args, rawCommand)
--     local ped = PlayerPedId()
--     local door = args[1]
--     local currVeh = GetVehiclePedIsIn(ped, false)
--     SetVehicleDoorOpen(currVeh, tonumber(door), false, false)
-- end, false)
