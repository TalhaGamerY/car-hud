Locales = Locales or {}

Locales['en'] = {
    hud_shown      = 'Vehicle HUD shown',
    hud_hidden     = 'Vehicle HUD hidden',
    keybind_label  = 'Toggle vehicle HUD',
    no_permission  = 'You do not have permission to use this command.',
    invalid_target = 'No player found with that ID.',
    toggled_for    = 'Toggled the HUD for player %s.',
}

-- Look up a translated string, falling back to the key itself.
function _L(key, ...)
    local lang = Locales[Config.Locale] or Locales['en']
    local text = lang[key] or key
    if select('#', ...) > 0 then
        return text:format(...)
    end
    return text
end
