RegisterCommand(Config.CommandName, function()
    SendCurrentVehicleDataToNui()

    Debug("[command:show-nui] ToggleNuiFrame called and set to true.")
end, false)
