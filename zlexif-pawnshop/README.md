## Zlexif's Pawn Shop Job.
join **[Discord] https://discord.gg/XAV4AfgQaZ** |

# Required
qb-core (https://github.com/qbcore-framework/qb-core)
qb-management (https://github.com/qbcore-framework/qb-management)
qb-target (https://github.com/qbcore-framework/qb-target)
qb-input (https://github.com/qbcore-framework/progressbar)
qb-menu (https://github.com/qbcore-framework/qb-menu)

# Drag The Bike Image from the folder [images] to your qb-inventory/html/images

# ADD THIS TO **qb-core/shared/items.lua**
    ['bike']                            = {['name'] = 'bike',                              ['label'] = 'Bike',                      ['weight'] = 10000,        ['type'] = 'item',         ['image'] = 'bike.png',                   ['unique'] = true,          ['useable'] = true,      ['shouldClose'] = false,      ['combinable'] = nil,   ['description'] = 'A deployable bike...'},

# IF YOU WANT THE BIKE TO ACTUALLY FUNCTION AND BE DEPLOYABLE ADD THIS TO
#qb-smallresources/client/consumables.lua
```RegisterNetEvent('consumables:client:bike', function(itemName)
    local ped = PlayerPedId()
    TriggerEvent('animations:client:EmoteCommandStart', {"inspect"})

    QBCore.Functions.Progressbar("drink_something", "Deploying Bike...", 3500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        ClearPedTasks(PlayerPedId())

        -- Remove the bike item from the player's inventory
        TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)
        TriggerEvent("QBCore:Notify", "Bike deployed!", "success")

        -- Added: Display notification and ensure removal
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")

        -- Cancel the animation
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})

        -- Create the bike
        local bikeModel = GetHashKey("bmx")
        local pedCoords = GetEntityCoords(ped)
        local bikeCoords = vector3(pedCoords.x + 2, pedCoords.y, pedCoords.z)
        RequestModel(bikeModel)
        while not HasModelLoaded(bikeModel) do
            Wait(50)
        end

        local bike = CreateVehicle(bikeModel, bikeCoords.x, bikeCoords.y, bikeCoords.z, 0.0, true, false)
        TaskWarpPedIntoVehicle(ped, bike, -1)

        -- Give the keys for the bike
        TriggerEvent('vehiclekeys:client:SetOwner', GetVehicleNumberPlateText(bike))
    end)
end)
```

# qb-smallresources/server/consumables.lua
```
-- BIKE
QBCore.Functions.CreateUseableItem("bike", function(source, item) -- "bike" is the item name you'd use to spawn the bike. Replace with your item name if different.
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
    TriggerClientEvent('consumables:client:bike', source, item.name)
    end
end)
```
# **qb-core/shared/jobs.lua**
```   ['pawn'] = {
		label = 'Pawn Shop',
		defaultDuty = true, -- If whenever you see the job your defaultly on duty
		offDutyPay = false, -- If you want employees to be paid even when theyre not on duty/off duty ( THIS IS IN GAME NOT WHEN YOUR OFFLINE COMPLETELY)
		grades = {
            ['0'] = {
                name = 'Runner', -- NAME OF THE GRADE
                payment = 650, -- PAYMENT FOR THIS GRADE ( EVERY 30 MINS OR ACCORDING TO YOUR loops.lua)  -- Configure According To Your Economy
            },
            ['1'] = {
                name = 'SalesMan',
                payment = 950, -- Configure According To Your Economy
            },
            ['2'] = {
                name = 'Trader',
                isboss = true,
                payment = 1400, -- Configure According To Your Economy
            },
            ['3'] = {
                name = 'Asst. Manager',
                isboss = true,
                payment = 1600,
            },
            ['4'] = {
                name = 'Manager',
                isboss = true,
                payment = 2000, -- Configure According To Your Economy
            },
        },
	}, ```
