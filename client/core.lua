SendCurrentVehicleDataToNui = function()
  local sourcePed = PlayerPedId()
  local playerId = PlayerId()

  if not IsPedInAnyVehicle(sourcePed, false) then return Debug("Ped isn't in any vehicle.") end

  -- Flag:CPED_CONFIG_FLAG_PreventAutoShuffleToDriversSeat
  SetPedConfigFlag(sourcePed, 184, true)

  local currVeh = GetVehiclePedIsIn(sourcePed, false)
  local vehModel = GetEntityModel(currVeh)
  local vehDoors = GetVehicleMaxNumberOfPassengers(currVeh)
  local vehSeats = GetVehicleModelNumberOfSeats(vehModel)
  local pedInDriverSeat = GetPedInVehicleSeat(currVeh, -1)
  local isDriver = pedInDriverSeat == sourcePed

  -- TODO: [Needs testing, i've attempted a fix] While using the GetNumberOfVehicleDoors func, it returns the trunk and hood included with the doors. (Needs to be better, some cars don't have one)

  -- Add a +1 for the driver as well.
  local vehData = {
    doors = vehDoors + 1,
    seats = vehSeats,
    isDriver = isDriver,
  }

  UIMessage("nui:state:vehdata", vehData)
  Debug("Vehicle Data: ", json.encode(vehData))
  ToggleNuiFrame(true)
end
