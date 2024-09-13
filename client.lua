-- // Variables

local cooldown = false

-- // Main stuff

Citizen.CreateThread(function()
    while true do    
        local sleep = 1000
    
        for _, location in ipairs(Config.Locations) do
            local distance = #(GetEntityCoords(PlayerPedId()) - vector3(location.Coords.x, location.Coords.y, location.Coords.z))

            if distance <= 10 then
                sleep = 0
                if distance <= 2.5 then
                    Draw3DText(location.Coords.x, location.Coords.y, location.Coords.z, Config.Text, 0.65)

                    if IsControlJustReleased(0, Config.Key) then
                        RequestModel(location.CarModel)
                        while not HasModelLoaded(location.CarModel) do
                          Wait(0)
                        end

                        local vehicle = CreateVehicle(location.CarModel, vector3(location.Coords.x, location.Coords.y - 2.5, location.Coords.z), location.Heading, true, false)

                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

                        cooldown = true
                        Citizen.Wait(Config.Cooldown * 1000)
                        cooldown = false
                    end
                end
            end
        end

        Citizen.Wait(sleep)
    end
end)

-- // 3D Text drawing

function Draw3DText(x, y, z, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local camCoords = GetGameplayCamCoords()

    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextOutline()

    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(_x, _y)
end

-- // Blips

Citizen.CreateThread(function()
    for _, location in ipairs(Config.Locations) do
        local blip = AddBlipForCoord(location.Coords.x, location.Coords.y, location.Coords.z)

        SetBlipSprite(blip, location.Blip.Sprite)
        SetBlipScale(blip, location.Blip.Scale)
        SetBlipColour(blip, location.Blip.Color)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(location.Blip.Name)
        EndTextCommandSetBlipName(blip)
    end
end)

-- // Creating ped

Citizen.CreateThread(function()
    for _, location in ipairs(Config.Locations) do
        local pedModel = GetHashKey(location.PedModel)
        
        RequestModel(pedModel)
        while not HasModelLoaded(pedModel) do
            Citizen.Wait(500)
        end
        
        local ped = CreatePed(4, pedModel, location.Coords.x, location.Coords.y, location.Coords.z - 1.0, location.Coords.heading, true, false)
        
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
        SetPedCanRagdollFromPlayerImpact(ped, false)
        SetPedDiesWhenInjured(ped, false)
        SetBlockingOfNonTemporaryEvents(ped, true)
    end
end)