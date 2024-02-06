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

-- CreateThread(function()
--   local txd = CreateRuntimeTxd('duiTxd')
--   local duiObj = CreateDui('http://i.imgur.com/bvhD7sq.gif', 5, 50)
--   local dui = GetDuiHandle(duiObj)
--   local tx = CreateRuntimeTextureFromDuiHandle(txd, 'duiTex', dui)


--   while true do
--     Wait(0)
--     local ratio = GetAspectRatio()

--     local pool = GetGamePool("CPed")
--     table.sort(pool,
--       function(a, b)
--         return #(GetEntityCoords(a) - GetFinalRenderedCamCoord()) >
--             #(GetEntityCoords(b) - GetFinalRenderedCamCoord())
--       end)

--     for i, v in pairs(pool) do
--       local boneId = 31086
--       local pos = GetWorldPositionOfEntityBone(v, GetPedBoneIndex(v, boneId))
--       local dist = #(GetFinalRenderedCamCoord() - pos)
--       local scale = (1.0 / dist) * (1.0 / GetFinalRenderedCamFov()) * 12.0
--       local visible = IsEntityVisible(v)
--       local los = HasEntityClearLosToEntity(PlayerPedId(), v, 17) or v == PlayerPedId()

--       if dist < 50.0 and los and visible then
--         SetDrawOrigin(pos)
--         DrawSprite("carter_outside", "comptwall22", 0.0, 0.0, scale, scale * ratio,
--           0.0, 255,
--           255, 255, 255)
--         SetPedComponentVariation(PlayerPedId(), 8, 0, 0, 2) -- Assuming 8 is the shirt component ID

--         ClearDrawOrigin()
--       end
--     end
--   end
-- end)
