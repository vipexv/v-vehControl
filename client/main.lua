--#region Variables
local interface = require "modules.interface.client"
local utils = require "modules.utils.shared"
local Debug = utils.Debug

Script = {
    State = {
        firstLoad = true,
    }
}
--#endregion Variables

--#region Functions
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

    -- With cars more than 4 passengers, it counts all of the extra seats as doors, which is why we are switching to the GetNumberOfVehicleDoors native.

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

    interface.message("nui:state:vehdata", vehData)

    if Script.State.firstLoad then
        interface.message("nui:state:config", Config)
        Debug("firstLoad, sending config.")
        Script.State.firstLoad = false
    end

    if updateData then return end

    interface.toggle(true)
end

--#endregion Functions

--#region Events
RegisterNetEvent("VehControl:UIMessage", function(action, data)
    interface.message(action, data)

    Debug("(netEvent) [VehControl:UIMessage] \n (param) action: ", json.encode(action), "\n (param) data: ",
        json.encode(data),
        "\n Invoking Resource: ",
        GetInvokingResource())
end)

RegisterNetEvent("vehiclecontrol:toggle", function()
    Debug("[vehiclecontrol:toggle] Called.")
    SendCurrentVehicleDataToNui()
end)
--#endregion Events

--#region Callbacks
RegisterNuiCallback('hideFrame', function(_, cb)
    cb(1)
    interface.toggle(false)
    Debug('[nuicb:hideFrame] called')
end)

RegisterNuiCallback("vehmenu:setseat", function(index, cb)
    cb(1)

    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    -- JS index starts at 0.
    local seatIndex = index - 1
    if not IsVehicleSeatFree(veh, seatIndex) then
        return Debug("Veh seat isn't free.")
    end

    SetPedIntoVehicle(ped, veh, seatIndex)
    SendCurrentVehicleDataToNui(true)
end)

RegisterNuiCallback("vehmenu:toggledoor", function(doorIndex, cb)
    cb(1)

    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if GetVehicleDoorAngleRatio(veh, doorIndex) > 0.0 then
        SetVehicleDoorShut(veh, doorIndex, false)
    else
        SetVehicleDoorOpen(veh, doorIndex, false, false)
    end

    SetTimeout(650, function()
        SendCurrentVehicleDataToNui(true)
    end)
end)

RegisterNuiCallback("vehmenu:togglefocus", function(bool, cb)
    cb(1)

    SetNuiFocus(true, bool)
end)

RegisterNuiCallback("vehmenu:togglewindow", function(windowIndex, cb)
    cb(1)

    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)

    if IsVehicleWindowIntact(veh, windowIndex) then
        RollDownWindow(veh, windowIndex)
    else
        RollUpWindow(veh, windowIndex)
    end
    SendCurrentVehicleDataToNui(true)
end)

---@param data VehicleOption
RegisterNuiCallback("vehmenu:toggleoption", function(data, cb)
    cb(1)

    local option = data.option
    local ped = PlayerPedId()
    local currVeh = GetVehiclePedIsIn(ped, false)
    local delay = 0

    if option == "engine" then
        local engineRunning = GetIsVehicleEngineRunning(currVeh)
        SetVehicleEngineOn(currVeh, not engineRunning, false, true)
        Debug("Engine set to: ", not engineRunning)
        -- The engine takes a bit to start up, updating state after that.
        delay = 1000
    end

    if option == "right_blinker" then
        local lightsState = GetVehicleIndicatorLights(currVeh)
        local lightsStateBool = lightsState ~= 2 and lightsState ~= 3
        SetVehicleIndicatorLights(currVeh, 0, lightsStateBool)
    end

    if option == "left_blinker" then
        local lightsState = GetVehicleIndicatorLights(currVeh)
        local lightsStateBool = lightsState ~= 1 and lightsState ~= 3
        SetVehicleIndicatorLights(currVeh, 1, lightsStateBool)
    end

    if option == "alert" then
        local lightsState = GetVehicleIndicatorLights(currVeh)

        if lightsState ~= 3 then
            SetVehicleIndicatorLights(currVeh, 0, true)
            SetVehicleIndicatorLights(currVeh, 1, true)
        else
            SetVehicleIndicatorLights(currVeh, 0, false)
            SetVehicleIndicatorLights(currVeh, 1, false)
        end
    end

    if option == "interior_light" then
        local currState = IsVehicleInteriorLightOn(currVeh)
        SetVehicleInteriorlight(currVeh, not currState)
    end

    if delay > 0 then
        SetTimeout(delay, function()
            SendCurrentVehicleDataToNui(true)
        end)
        return
    end

    SendCurrentVehicleDataToNui(true)
end)
--#endregion Callbacks

--#region Commands
RegisterCommand(Config.CommandName, function()
    SendCurrentVehicleDataToNui()

    Debug("[command] ToggleNuiFrame called and set to true.")
end, false)
--#endregion Commands

--#region Keybinds
if Config.Keybind.enabled then
    RegisterKeyMapping(Config.CommandName, "Open the Vehicle Control Menu", "keyboard", Config.Keybind.key)
end
--#engregion Keybinds
