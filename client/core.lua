SendCurrentVehicleDataToNui = function()
  local pedId = PlayerPedId()
  local playerId = PlayerId()

  if not IsPedInAnyVehicle(pedId, false) then return Debug("Ped isn't in any vehicle.") end

  local currVeh = GetVehiclePedIsIn(pedId, false)
  local vehModel = GetEntityModel(currVeh)

  local vehicleSeats = GetVehicleModelNumberOfSeats(vehModel)

  Debug("vehicleSeats: ", json.encode(vehicleSeats))
end
