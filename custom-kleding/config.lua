Config = {}

-- Command om het menu overal te openen (zet op false om uit te schakelen)
Config.Command = 'kleding'

-- Plekken waar je met [E] het menu kunt openen
Config.Locaties = {
    { label = 'Kledingkast Politiebureau', coords = vec3(461.45, -998.05, 30.69) },
    { label = 'Kledingkast Ziekenhuis',    coords = vec3(298.60, -598.50, 43.28) },
}
Config.InteractieAfstand = 1.5

-- Voorbeeld outfits.
-- components: component_id (0-11), drawable, texture
--   1 = masker, 3 = armen/torso, 4 = broek, 5 = tas, 6 = schoenen,
--   7 = accessoires, 8 = onderhemd, 9 = vest, 11 = jas/shirt
-- props: prop_id (0 = hoed, 1 = bril, 2 = oren, 6 = horloge, 7 = armband)
--   drawable = -1 betekent: prop verwijderen
Config.Outfits = {
    {
        label = 'Casual',
        icon = 'shirt',
        male = {
            components = {
                { component_id = 11, drawable = 0,  texture = 0 },
                { component_id = 8,  drawable = 15, texture = 0 },
                { component_id = 3,  drawable = 0,  texture = 0 },
                { component_id = 4,  drawable = 4,  texture = 0 },
                { component_id = 6,  drawable = 1,  texture = 0 },
            },
            props = {
                { prop_id = 0, drawable = -1, texture = 0 },
            },
        },
        female = {
            components = {
                { component_id = 11, drawable = 3,  texture = 0 },
                { component_id = 8,  drawable = 14, texture = 0 },
                { component_id = 3,  drawable = 3,  texture = 0 },
                { component_id = 4,  drawable = 4,  texture = 0 },
                { component_id = 6,  drawable = 3,  texture = 0 },
            },
            props = {
                { prop_id = 0, drawable = -1, texture = 0 },
            },
        },
    },
    {
        label = 'Pak',
        icon = 'user-tie',
        male = {
            components = {
                { component_id = 11, drawable = 4,  texture = 0 },
                { component_id = 8,  drawable = 31, texture = 0 },
                { component_id = 7,  drawable = 10, texture = 0 },
                { component_id = 3,  drawable = 4,  texture = 0 },
                { component_id = 4,  drawable = 10, texture = 0 },
                { component_id = 6,  drawable = 10, texture = 0 },
            },
            props = {},
        },
        female = {
            components = {
                { component_id = 11, drawable = 6,  texture = 0 },
                { component_id = 8,  drawable = 38, texture = 0 },
                { component_id = 3,  drawable = 5,  texture = 0 },
                { component_id = 4,  drawable = 6,  texture = 0 },
                { component_id = 6,  drawable = 6,  texture = 0 },
            },
            props = {},
        },
    },
}
