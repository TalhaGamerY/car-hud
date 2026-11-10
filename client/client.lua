local hudEnabled = Config.VisibleByDefault
local hudShowing = false

local function notify(text)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandThefeedPostTicker(false, false)
end

local function setVisible(visible)
    if hudShowing == visible then return end
    hudShowing = visible
    SendNUIMessage({ action = 'visible', visible = visible })
end

local function toggleHud()
    hudEnabled = not hudEnabled
    notify(hudEnabled and _L('hud_shown') or _L('hud_hidden'))
    if not hudEnabled then setVisible(false) end
end

-- Send the config to the UI once it has loaded
CreateThread(function()
    Wait(500)
    SendNUIMessage({
        action   = 'config',
        units    = Config.Units,
        position = Config.Position,
        theme    = Config.Theme,
    })
end)

RegisterCommand('carhud', toggleHud, false)
RegisterKeyMapping('carhud', _L('keybind_label'), 'keyboard', Config.ToggleKey)

-- Fired by the server when an admin uses /hudtoggle on this player
RegisterNetEvent('car-hud:toggle', toggleHud)

local speedMultiplier = Config.Units == 'mph' and 2.236936 or 3.6

CreateThread(function()
    while true do
        local sleep = 500
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)

        if hudEnabled and vehicle ~= 0 and not IsPauseMenuActive() then
            sleep = Config.UpdateInterval
            setVisible(true)

            local _, lowBeam, highBeam = GetVehicleLightsState(vehicle)
            local gear = GetVehicleCurrentGear(vehicle)
            local speed = GetEntitySpeed(vehicle) * speedMultiplier

            if gear == 0 and speed > 1.0 then
                gear = 'R'
            elseif gear == 0 then
                gear = 'N'
            end

            SendNUIMessage({
                action = 'update',
                speed  = math.floor(speed + 0.5),
                gear   = gear,
                rpm    = GetVehicleCurrentRpm(vehicle),
                fuel   = GetVehicleFuelLevel(vehicle),
                engine = GetVehicleEngineHealth(vehicle),
                lights = (lowBeam == 1 or highBeam == 1),
                engineOn = GetIsVehicleEngineRunning(vehicle),
            })
        else
            setVisible(false)
        end

        Wait(sleep)
    end
end)
