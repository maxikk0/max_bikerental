Config = {}

--███╗   ███╗ █████╗ ██╗  ██╗███████╗ ██████╗██████╗ ██╗██████╗ ████████╗███████╗
--████╗ ████║██╔══██╗╚██╗██╔╝██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝
--██╔████╔██║███████║ ╚███╔╝ ███████╗██║     ██████╔╝██║██████╔╝   ██║   ███████╗
--██║╚██╔╝██║██╔══██║ ██╔██╗ ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   ╚════██║
--██║ ╚═╝ ██║██║  ██║██╔╝ ██╗███████║╚██████╗██║  ██║██║██║        ██║   ███████║
--╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   ╚══════╝
                                                                               
-------------------------------------------- General --------------------------------------------

Config.Key = 38 -- Key to rent a bike, Default key is E / https://docs.fivem.net/docs/game-references/controls/

Config.CarModel = 'bmx' -- Model of the vehicle to spawn

Config.Cooldown = 600 -- Cooldown in seconds before renting another bike

Config.PedModel = 'a_m_m_skater_01' -- https://docs.fivem.net/docs/game-references/ped-models/

Config.Coords = {
    { x = -1016.6138, y = -2696.1838, z = 13.9773, heading = 150.0 }, -- Example entry, add more as needed
    -- Add more entries for other coordinates
}
-------------------------------------------- Locales --------------------------------------------

Config.Text = "[E] Rent a bike" -- 3D Text displayed when player is near the bike rental spot
Config.NotifyText = 'You will be able to rent a next bike after '..Config.Cooldown..' seconds' -- Notification text for cooldown information

-------------------------------------------- Blips --------------------------------------------

-- https://docs.fivem.net/docs/game-references/blips/

Config.BlipName = "Bike Rental"
Config.BlipScale = 0.8 
Config.BlipColor = 47
Config.BlipSprite = 1