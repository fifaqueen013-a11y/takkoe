# custom-kleding

Custom kledingmenu voor een FiveM **ESX**-server, gebouwd op **illenium-appearance** en **ox_lib**.

Outfits worden opgeslagen via illenium-appearance zelf, dus ze worden bewaard in je ESX-database (`users.skin`). Je hoeft hiervoor niets extra's in te stellen.

## Functies
- **Kleding aanpassen**: opent de kledingwinkel van illenium-appearance met alleen kleding en accessoires (geen gezicht of haar)
- **Outfits**: voorbeeld-outfits uit `config.lua`, met aparte versies voor man en vrouw
- **Opgeslagen outfits**: opent het outfitmenu van illenium-appearance
- Hoed, bril en masker snel af- en opzetten
- Te openen met `/kleding` of met **[E]** op de plekken uit `Config.Locaties`

## Installatie
1. Zet de map `custom-kleding` in je `resources` map.
2. Zet in `server.cfg` deze volgorde aan:
   ```
   ensure es_extended
   ensure ox_lib
   ensure illenium-appearance
   ensure custom-kleding
   ```
3. Gebruik je nog `esx_skin` of `skinchanger`? Zet die dan uit, want illenium-appearance vervangt ze.

## Eigen outfit toevoegen
Voeg in `config.lua` een blok toe aan `Config.Outfits`:
```lua
{
    label = 'Mijn outfit',
    icon = 'shirt',
    male = {
        components = { { component_id = 11, drawable = 15, texture = 0 } },
        props = { { prop_id = 0, drawable = -1, texture = 0 } },
    },
    female = { components = {}, props = {} },
},
```
Tip: zoek de nummers op in de illenium-appearance kledingwinkel. Daar zie je bij elk onderdeel het drawable- en texture-nummer.

## Vanuit een ander script openen
```lua
exports['custom-kleding']:openMenu()
```
