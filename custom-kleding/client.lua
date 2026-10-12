local MALE = `mp_m_freemode_01`

local function isMale()
    return GetEntityModel(cache.ped) == MALE
end

-- Sla de huidige appearance op via illenium-appearance
local function saveAppearance()
    local appearance = exports['illenium-appearance']:getPedAppearance(cache.ped)
    TriggerServerEvent('illenium-appearance:server:saveAppearance', appearance)
end

-- Opent de kledingwinkel van illenium-appearance met alleen kleding (geen gezicht/haar)
local function openClothingShop()
    local config = {
        ped = false,
        headBlend = false,
        faceFeatures = false,
        headOverlays = false,
        components = true,
        componentConfig = {
            masks = true, upperBody = true, lowerBody = true, bags = true,
            shoes = true, scarfAndChains = true, bodyArmor = false,
            shirts = true, decals = false, jackets = true,
        },
        props = true,
        propConfig = {
            hats = true, glasses = true, ear = true, watches = true, bracelets = true,
        },
        tattoos = false,
        enableExit = true,
    }

    exports['illenium-appearance']:startPlayerCustomization(function(appearance)
        if appearance then
            TriggerServerEvent('illenium-appearance:server:saveAppearance', appearance)
            lib.notify({ title = 'Kleding', description = 'Outfit opgeslagen', type = 'success' })
        else
            lib.notify({ title = 'Kleding', description = 'Geannuleerd', type = 'inform' })
        end
    end, config)
end

local function applyOutfit(outfit)
    local data = isMale() and outfit.male or outfit.female
    if not data then return end

    exports['illenium-appearance']:setPedComponents(cache.ped, data.components or {})
    exports['illenium-appearance']:setPedProps(cache.ped, data.props or {})
    saveAppearance()

    lib.notify({ title = 'Kleding', description = ('Outfit "%s" aangetrokken'):format(outfit.label), type = 'success' })
end

-- Hoed/bril/masker af- of opzetten
local stored = {}

local function toggleProp(propId, label)
    local ped = cache.ped
    local current = GetPedPropIndex(ped, propId)

    if current ~= -1 then
        stored[propId] = { drawable = current, texture = GetPedPropTextureIndex(ped, propId) }
        ClearPedProp(ped, propId)
        lib.notify({ title = 'Kleding', description = label .. ' afgezet' })
    elseif stored[propId] then
        SetPedPropIndex(ped, propId, stored[propId].drawable, stored[propId].texture, true)
        lib.notify({ title = 'Kleding', description = label .. ' opgezet' })
    end
end

local function toggleMask()
    local ped = cache.ped
    local current = GetPedDrawableVariation(ped, 1)

    if current ~= 0 then
        stored.mask = { drawable = current, texture = GetPedTextureVariation(ped, 1) }
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        lib.notify({ title = 'Kleding', description = 'Masker afgedaan' })
    elseif stored.mask then
        SetPedComponentVariation(ped, 1, stored.mask.drawable, stored.mask.texture, 0)
        lib.notify({ title = 'Kleding', description = 'Masker opgedaan' })
    end
end

local function openMenu()
    local outfitOptions = {}
    for _, outfit in ipairs(Config.Outfits) do
        outfitOptions[#outfitOptions + 1] = {
            title = outfit.label,
            icon = outfit.icon or 'shirt',
            onSelect = function() applyOutfit(outfit) end,
        }
    end

    lib.registerContext({
        id = 'custom_kleding_outfits',
        title = 'Voorbeeld outfits',
        menu = 'custom_kleding_menu',
        options = outfitOptions,
    })

    lib.registerContext({
        id = 'custom_kleding_menu',
        title = 'Kledingmenu',
        options = {
            {
                title = 'Kleding aanpassen',
                description = 'Open de illenium-appearance kledingwinkel',
                icon = 'shirt',
                onSelect = openClothingShop,
            },
            {
                title = 'Outfits',
                description = 'Kies een voorbeeld outfit',
                icon = 'layer-group',
                menu = 'custom_kleding_outfits',
            },
            {
                title = 'Opgeslagen outfits',
                description = 'Je eigen outfits uit illenium-appearance',
                icon = 'floppy-disk',
                onSelect = function()
                    TriggerEvent('illenium-appearance:client:openOutfitMenu')
                end,
            },
            { title = 'Hoed af/op',   icon = 'hat-cowboy', onSelect = function() toggleProp(0, 'Hoed') end },
            { title = 'Bril af/op',   icon = 'glasses',    onSelect = function() toggleProp(1, 'Bril') end },
            { title = 'Masker af/op', icon = 'mask',       onSelect = toggleMask },
        },
    })

    lib.showContext('custom_kleding_menu')
end

exports('openMenu', openMenu)

if Config.Command then
    RegisterCommand(Config.Command, openMenu, false)
end

-- Interactiepunten
for _, loc in ipairs(Config.Locaties) do
    local point = lib.points.new({ coords = loc.coords, distance = Config.InteractieAfstand })

    function point:onEnter()
        lib.showTextUI(('[E] %s'):format(loc.label))
    end

    function point:onExit()
        lib.hideTextUI()
    end

    function point:nearby()
        if IsControlJustReleased(0, 38) then
            openMenu()
        end
    end
end
