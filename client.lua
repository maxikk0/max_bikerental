local coordsPos = Config.Coords
local playerPed = PlayerPedId()
local onFoot, coords = nil, vector3(0, 0, 0)
local cooldown = false

Citizen.CreateThread(function()
    while true do
        coords = GetEntityCoords(playerPed)
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function() -- Drawing 3D Text
    while true do
        Citizen.Wait(0)
        local sleep = true
        local isPlayerInVehicle = IsPedInAnyVehicle(playerPed)

        for _, coordsPos in ipairs(Config.Coords) do
            local distance = #(coords - vector3(coordsPos.x, coordsPos.y, coordsPos.z))
            if distance <= 10 then
                sleep = false
                if distance <= 1.5 and not isPlayerInVehicle and not cooldown then
                    Draw3DText(coordsPos.x, coordsPos.y, coordsPos.z, Config.Text, 0.65)
                end
            end
        end
        if sleep then 
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function() -- Spawning vehicle
    while true do
        Citizen.Wait(0)
        local sleep = true
        for _, coordsPos in ipairs(Config.Coords) do
            local distance = #(coords - vector3(coordsPos.x, coordsPos.y, coordsPos.z))
            if distance <= 10 then
                sleep = false
                if distance <= 1.5 and IsControlJustReleased(0, Config.Key) and not cooldown then
                    ESX.Game.SpawnVehicle(Config.CarModel, vector3(coordsPos.x, coordsPos.y-1.0, coordsPos.z), 265.0, function(vehicle)
                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                    end)

                    ESX.ShowNotification(Config.NotifyText)

                    cooldown = true
                    Citizen.Wait(Config.Cooldown * 1000)
                    cooldown = false
                end
            end
        end
        if sleep then
            Citizen.Wait(1000)
        end
    end
end)

function Draw3DText(x,y,z,text,scale) -- Function to draw 3D Text
    local OnScreen, _x, _y = World3dToScreen2d(x,y,z)
    local pX,pY,pZ = table.unpack(GetGameplayCamCoords())
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(_x,_y)
    SetTextOutline()
end

-- BLIPS
Citizen.CreateThread(function()
    for _, coordsPos in ipairs(Config.Coords) do
        local blip = AddBlipForCoord(coordsPos.x, coordsPos.y, coordsPos.z)

        SetBlipSprite(blip, Config.BlipSprite)  -- Change the blip sprite as needed
        SetBlipScale(blip, Config.BlipScale)
        SetBlipColour(blip, Config.BlipColor)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.BlipName)
        EndTextCommandSetBlipName(blip)
    end
end)

-- PEDS
Citizen.CreateThread(function()
    for _, coordsPos in ipairs(Config.Coords) do
        local hash = GetHashKey(Config.PedModel)
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(1)
        end

        ped = CreatePed(4, hash, coordsPos.x, coordsPos.y, coordsPos.z-1.0, coordsPos.heading, true, false)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
        SetPedCanRagdollFromPlayerImpact(ped, false)
        SetPedDiesWhenInjured(ped, false)
        SetBlockingOfNonTemporaryEvents(ped, true)
    end
end)