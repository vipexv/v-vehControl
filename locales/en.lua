-- Example taken from vAdmin.

local Translations = {
    ban_info =
    "❌ What the fluff dude, you're banned :O.\n\nBanned by: %{staffMember}\nBan Reason: %{banReason}\n Ban Date: %{banDate} \n Expiration Date: %{expirationDate} (%{expirationTime}) \n Ban ID: %{banId} \n\nIf you feel like this was a mistake, please go ahead and contact our support team.",
    kick_message =
    "❌ You have been kicked from the server. \n \n Kicked by Staff Member: %{staff_member_name} (id - %{staff_member_id}) \n Reason: %{kick_reason} \n \n Feel free to make a ticket at discord.gg/narco if you feel like this was a mistake.",
    drop_player_ban_message =
    "❌ What the fluff dude! \n You have been banned :O \n \n Staff Member: %{staff_member_name} (id - %{staff_member_id}) \n Ban Reason: %{ban_reason} \n Ban Length: %{ban_length} \n Ban ID: %{ban_id}\n Rejoin for more info. \n \n If you feel like this was a mistake, feel free to open a ticket at discord.gg/narco to appeal it.",
    cheating_kick_message =
    "You have been kicked for cheating. \n \n If you feel like this was a mistake, please go ahead and report it."
}


Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
