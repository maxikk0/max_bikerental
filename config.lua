Config = {}
                                                                               
-------------------------------------------- General --------------------------------------------

Config.Key = 38 -- Key to rent a bike, Default key is E / https://docs.fivem.net/docs/game-references/controls/

Config.Cooldown = 600 -- Cooldown in seconds before renting another vehicle

Config.Locations = {
    {
        PedModel = 'a_m_m_skater_01', -- https://docs.fivem.net/docs/game-references/ped-models/
        CarModel = 'bmx', -- https://docs.fivem.net/docs/game-references/vehicle-models/
        Coords = { x = -1016.6138, y = -2696.1838, z = 13.9773, heading = 150.0 }, -- Coordinates for the location
        Blip = { -- https://docs.fivem.net/docs/game-references/blips/
            Name = "Bike Rental", -- Blip name
            Sprite = 1, -- Blip icon sprite
            Color = 47, -- Blip color
            Scale = 0.8 -- Blip scale
        }
    },
    -- More..
}
-------------------------------------------- Locales --------------------------------------------

Config.Text = "[E] Rent a bike" -- 3D Text displayed when player is near the bike rental spot