Script = {
  State = {
    firstLoad = true,
  }
}

---@param updateData? boolean
SendCurrentVehicleDataToNui = function(updateData)
  local sourcePed = PlayerPedId()

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
  local currSeat = nil

  -- With cars more than 4 passengers, it counts all of the extra seats as doors, for example the bus itself, which is why we are switching to the GetNumberOfVehicleDoors native.

  local doors = vehDoors > 4 and vehDoorsAlternative or vehDoors

  local openDoors = {}
  local closedWindows = {}

  -- Current Seat
  for i = -1, vehSeats - 2 do
    local pedInSeat = GetPedInVehicleSeat(currVeh, i)

    if pedInSeat ~= 0 and pedInSeat == sourcePed then
      currSeat = i
    end
  end


  --  State's for doors and windows.
  for i = 0, doors - 1 do
    local isVehicleDoorOpen = GetVehicleDoorAngleRatio(currVeh, i) > 0.0
    local isWindowOpen = IsVehicleWindowIntact(currVeh, i)

    if isVehicleDoorOpen then
      openDoors[#openDoors + 1] = i
    end

    if not isWindowOpen then
      closedWindows[#closedWindows + 1] = i
    end
  end

  --Trunk and Hood | Code quality isn't the best but we will work on it in the future, it works for now.
  local isHoodOpen = GetVehicleDoorAngleRatio(currVeh, 4) > 0.0
  local isTrunkOpen = GetVehicleDoorAngleRatio(currVeh, 5) > 0.0

  if isHoodOpen then
    openDoors[#openDoors + 1] = 4
  end

  if isTrunkOpen then
    openDoors[#openDoors + 1] = 5
  end

  local vehData = {
    doors = doors,
    seats = vehSeats,
    currSeat = currSeat,
    engineOn = GetIsVehicleEngineRunning(currVeh),
    indicatorLights = GetVehicleIndicatorLights(currVeh),
    openDoors = openDoors,
    closedWindows = closedWindows,
    interiorLight = IsVehicleInteriorLightOn(currVeh),
  }

  UIMessage("nui:state:vehdata", vehData)

  if Script.State.firstLoad then
    UIMessage("nui:state:config", Config)
    Debug("firstLoad, sending config.")
    Script.State.firstLoad = false
  end

  if updateData then return end

  ToggleNuiFrame(true)
end


if Config.Keybind.enabled then
  RegisterKeyMapping(Config.CommandName, "Open the Vehicle Control Menu", "keyboard", Config.Keybind.key)
end
