SendCurrentVehicleDataToNui = function()
  local pedId = PlayerPedId()
  local playerId = PlayerId()

  if not IsPedInAnyVehicle(pedId, false) then return Debug("Ped isn't in any vehicle.") end

  local currVeh = GetVehiclePedIsIn(pedId, false)
  local vehModel = GetEntityModel(currVeh)
  local vehDoors = GetNumberOfVehicleDoors(currVeh)
  local vehSeats = GetVehicleModelNumberOfSeats(vehModel)

  local vehData = {
    doors = vehDoors - 2,
    seats = vehSeats,
  }

  UIMessage("nui:state:vehdata", vehData)
  Debug("Vehicle Data: ", json.encode(vehData))
end
