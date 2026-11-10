Config = {}

-- "standalone" or "esx". ESX is only used for the admin check on /hudtoggle.
Config.Framework = "standalone"

-- Language file to use from the locale folder
Config.Locale = "en"

-- "kmh" or "mph"
Config.Units = "kmh"

-- Show the HUD automatically when entering a vehicle
Config.VisibleByDefault = true

-- Key players press to show/hide their own HUD (they can rebind it in GTA settings)
Config.ToggleKey = "F9"

-- How often the HUD updates while driving, in milliseconds
Config.UpdateInterval = 100

-- Where the HUD sits: "bottom-right", "bottom-left", "bottom-center"
Config.Position = "bottom-right"

-- Who can use /hudtoggle [id] on other players.
--   esx: these ESX groups
--   standalone: players with the ACE permission below (add_ace group.admin carhud.admin allow)
Config.AdminGroups = { "admin", "superadmin" }
Config.AcePermission = "carhud.admin"

-- Colours (any CSS colour)
Config.Theme = {
    accent     = "#38bdf8",
    background = "rgba(10, 14, 22, 0.78)",
    text       = "#f1f5f9",
    muted      = "#94a3b8",
    warning    = "#f97316",
    danger     = "#ef4444",
}
