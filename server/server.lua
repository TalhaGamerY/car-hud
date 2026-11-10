local ESX

if Config.Framework == 'esx' then
    CreateThread(function()
        ESX = exports['es_extended']:getSharedObject()
    end)
end

local function isAdmin(source)
    if source == 0 then return true end -- server console

    if Config.Framework == 'esx' and ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return false end
        local group = xPlayer.getGroup()
        for _, allowed in ipairs(Config.AdminGroups) do
            if group == allowed then return true end
        end
        return false
    end

    return IsPlayerAceAllowed(source, Config.AcePermission)
end

local function reply(source, text)
    if source == 0 then
        print(text)
    else
        TriggerClientEvent('chat:addMessage', source, { args = { 'Car HUD', text } })
    end
end

-- /hudtoggle [id] - toggles the HUD for a player (yourself if no id is given)
RegisterCommand('hudtoggle', function(source, args)
    if not isAdmin(source) then
        return reply(source, _L('no_permission'))
    end

    local target = tonumber(args[1]) or source
    if target == 0 or not GetPlayerName(target) then
        return reply(source, _L('invalid_target'))
    end

    TriggerClientEvent('car-hud:toggle', target)
    if target ~= source then
        reply(source, _L('toggled_for', target))
    end
end, false)
