local QBCore = exports['qb-core']:GetCoreObject()
local NUIList = {}
local BlipList = {}

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Citizen.Wait(1000)
        loadstuff()
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    loadstuff()
end)

function loadstuff()
    SendNUIMessage({
        type = 'load',
        list = NUIList
    })

    for k,v in pairs(Config.blips) do
        NUIList[k] = k
    end

    for k,v in pairs(Config.blips) do
        if Config.blips[k].ischecked then
            for l,b in pairs(Config.blips[k].coords) do
                BlipList[k..l] = AddBlipForCoord(b.loc)
                SetBlipSprite(BlipList[k..l], b.blip.sprite)
                SetBlipScale(BlipList[k..l], b.blip.scale)
                SetBlipColour(BlipList[k..l], b.blip.color)
                SetBlipDisplay(BlipList[k..l], 4)
                SetBlipAsShortRange(BlipList[k..l], true)

                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(b.name)
                EndTextCommandSetBlipName(BlipList[k..l])
            end
        end
    end
end

RegisterNUICallback('ToggleBlips', function(data, cb)
    if data.type == 'remove' then
        Config.blips[data.name].ischecked = false
        for k,v in pairs(Config.blips[data.name].coords) do
            if DoesBlipExist(BlipList[data.name..k]) then
                RemoveBlip(BlipList[data.name..k])
            end
        end
    else
        Config.blips[data.name].ischecked = true
        for l,b in pairs(Config.blips[data.name].coords) do
            BlipList[data.name..l] = AddBlipForCoord(b.loc)
            SetBlipSprite(BlipList[data.name..l], b.blip.sprite)
            SetBlipScale(BlipList[data.name..l], b.blip.scale)
            SetBlipColour(BlipList[data.name..l], b.blip.color)
            SetBlipDisplay(BlipList[data.name..l], 4)
            SetBlipAsShortRange(BlipList[data.name..l], true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(b.name)
            EndTextCommandSetBlipName(BlipList[data.name..l])
        end
    end
end)

RegisterNUICallback('CloseNui', function(data, cb)
    SetNuiFocus(false, false)
end)

RegisterCommand('gps', function(source, args, rawCommand)
    SendNUIMessage({
        type = 'setup',
        list = NUIList
    })
    SetNuiFocus(true, true)
end)

RegisterNetEvent('blips:client:openMenu', function()
    SendNUIMessage({
        type = 'setup',
        list = NUIList
    })
    SetNuiFocus(true, true)
end)