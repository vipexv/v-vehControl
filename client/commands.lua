RegisterCommand(Config.CommandName, function()
    SendCurrentVehicleDataToNui()

    Debug("[command] ToggleNuiFrame called and set to true.")
end, false)
