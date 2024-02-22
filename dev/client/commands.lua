RegisterCommand("car", function(source, args, rawCommand)
    local carModel = args[1]

    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local pedHeading = GetEntityHeading(ped)
    local isInVeh = IsPedInAnyVehicle(ped, false)

    if isInVeh then
        local currVeh = GetVehiclePedIsIn(ped, false)

        SetEntityAsNoLongerNeeded(currVeh)
        SetModelAsNoLongerNeeded(currVeh)

        DeleteEntity(currVeh)
    end

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


RegisterCommand("door", function(source, args, rawCommand)
    local ped = PlayerPedId()
    local door = args[1]
    local currVeh = GetVehiclePedIsIn(ped, false)
    SetVehicleDoorOpen(currVeh, tonumber(door), false, false)
end, false)

RegisterCommand("setPed", function(source, args, rawCommand)
    ---@type string
    local modelString = args[1]
    local modelHash = GetHashKey(modelString)

    if not IsModelInCdimage(modelHash) then
        error("invalid spawn model")
    end

    RequestModel(modelHash)

    while not HasModelLoaded(modelHash) do
        RequestModel(modelHash)
        Wait(0)
    end

    SetPlayerModel(PlayerId(), modelHash)

    SetModelAsNoLongerNeeded(modelHash)

    local ped = PlayerPedId()

    if modelString:find("freemode_01") then
        SetPedComponentVariation(ped, 0, 0, 0, 0)
    end
end, false)
