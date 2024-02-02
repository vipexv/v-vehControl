SendCurrentVehicleDataToNui = function()
  local pedId = PlayerPedId()
  local playerId = PlayerId()

  if not IsPedInAnyVehicle(pedId, false) then return Debug("Ped isn't in any vehicle.") end

  local currVeh = GetVehiclePedIsIn(pedId, false)
  local vehModel = GetEntityModel(currVeh)
  local vehDoors = GetVehicleMaxNumberOfPassengers(currVeh)
  local vehSeats = GetVehicleModelNumberOfSeats(vehModel)


  -- TODO: While using the GetNumberOfVehicleDoors func, it returns the trunk and hood included with the doors. (Needs to be better, some cars don't have one)

  -- Add a +1 for the driver as well.
  local vehData = {
    doors = vehDoors + 1,
    seats = vehSeats,
  }

  UIMessage("nui:state:vehdata", vehData)
  Debug("Vehicle Data: ", json.encode(vehData))
end
