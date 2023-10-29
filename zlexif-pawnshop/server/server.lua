local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('zlexif-pawn:server:Craft', function(data, weapon)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local receiveAmount = 1
    Player.Functions.AddItem(data, receiveAmount)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[data], "add")
end)
RegisterNetEvent('zlexif-runs:reward')
AddEventHandler('zlexif-runs:reward', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        -- add item to the player's inventory
        Player.Functions.AddItem(item, 1) -- gives 1 unit of each item
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
    end
end)

QBCore.Functions.CreateCallback('zlexif-pawn:server:Materials', function(source, cb, materials)
    local src = source
    local tem = 0
    local player = QBCore.Functions.GetPlayer(source)
    for k, v in pairs(materials) do
        if player.Functions.GetItemByName(v.item) and player.Functions.GetItemByName(v.item).amount >= v.amount then
            tem = tem + 1
            if tem == #materials then
                cb(true)
            end
        else
            cb(false)
            return
        end
    end
end)
RegisterServerEvent('zlexif-runs:reward')
AddEventHandler('zlexif-runs:reward', function(item, quantity)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        -- Add the item to the player's inventory
        Player.Functions.AddItem(item, quantity)
        TriggerClientEvent('QBCore:Notify', src, 'You received ' .. tostring(quantity) .. ' ' .. item, 'success')
    end
end)
-- Table to keep track of players' peds
local playerPeds = {}

-- Event to store the ped for a player
RegisterNetEvent('zlexif-runs:registerPed')
AddEventHandler('zlexif-runs:registerPed', function(ped)
    local src = source
    playerPeds[src] = ped
end)

-- Event to clear the ped
RegisterNetEvent('zlexif-runs:clearPed')
AddEventHandler('zlexif-runs:clearPed', function()
    local src = source
    playerPeds[src] = nil  -- This will 'forget' the ped ID, effectively disassociating it from the player.
end)

