SendCurrentVehicleDataToNui = function()
  local sourcePed = PlayerPedId()
  local playerId = PlayerId()

  if not IsPedInAnyVehicle(sourcePed, false) then return Debug("Ped isn't in any vehicle.") end

  -- Flag:CPED_CONFIG_FLAG_PreventAutoShuffleToDriversSeat
  SetPedConfigFlag(sourcePed, 184, true)

  local currVeh = GetVehiclePedIsIn(sourcePed, false)
  local vehModel = GetEntityModel(currVeh)

  -- Add a +1 for the driver as well.
  local vehDoors = GetVehicleMaxNumberOfPassengers(currVeh) + 1
  -- Remove 2, it counts the hood/trunk if any.
  local vehDoorsAlternative = GetNumberOfVehicleDoors(currVeh) - 2
  local vehSeats = GetVehicleModelNumberOfSeats(vehModel)
  local pedInDriverSeat = GetPedInVehicleSeat(currVeh, -1)
  local isDriver = pedInDriverSeat == sourcePed

  local doors = vehDoors > 4 and vehDoorsAlternative or vehDoors

  local vehData = {
    doors = doors,
    seats = vehSeats,
    isDriver = isDriver,
  }

  UIMessage("nui:state:vehdata", vehData)
  Debug("Vehicle Data: ", json.encode(vehData))
  ToggleNuiFrame(true)
end
