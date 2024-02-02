# Zlexif's Pawn Shop Job for QBCore

- Enhance your GTA V roleplay server with Zlexif's Pawn Shop Job, a comprehensive script that introduces a fully functional pawn shop job to  QBCore. Engage in buying, selling, and pawning items for a unique RP experience.

# Quick Links
- Join our community for support and updates: [Discord](https://discord.com/invite/XAV4AfgQaZ)

# Requirements
- [qb-core](https://github.com/qbcore-framework/qb-core) The core framework.
- [qb-management](https://github.com/qbcore-framework/qb-management) For job management functionalities.
- [qb-target-OPTIONAl](https://github.com/qbcore-framework/qb-target) For interactive world elements.
- [qb-input](https://github.com/qbcore-framework/progressbar) For user input prompts.
- [qb-menu](https://github.com/qbcore-framework/qb-menu) For in-game menus.

- Additionally, download and install the custom MLO for the pawn shop: - [Google Drive Link](https://drive.google.com/file/d/1eZs2_fVmbyJRw9Lvx3XNPFpWjA0SiAMW/view)



# Installation Guide
Step 1: Resource Setup
- Download the pawn shop script and the required resources listed above.
- Drag and drop the resources into your server's resources folder.
- Ensure all resources are correctly started in your server.cfg.
Step 2: Item and Job Configuration
For the qb-core shared items:
# New QBCore Version:
- Add the following line to your qb-core/shared/items.lua to include the deployable bike item:

```
bike = {name = 'bike', label = 'Bike', weight = 10000, type = 'item', image = 'bike.png', unique = true, useable = true, shouldClose = false, combinable = nil, description = 'A deployable bike...'},
```

For the qb-core shared jobs:

- Add or adjust the pawn shop job details in your qb-core/shared/jobs.lua:
```
pawn = {
    label = 'Pawn Shop',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
        ['0'] = {name = 'Runner', payment = 650},
        ['1'] = {name = 'SalesMan', payment = 950},
        ['2'] = {name = 'Trader', isboss = true, payment = 1400},
        ['3'] = {name = 'Asst. Manager', isboss = true, payment = 1600},
        ['4'] = {name = 'Manager', isboss = true, payment = 2000},
    },
},
```
Step 3: Consumable Bike Deployment
# Client-side (qb-smallresources):

- In qb-smallresources/client/consumables.lua, add the bike deployment functionality:
```
RegisterNetEvent('consumables:client:bike', function(itemName)
    local ped = PlayerPedId()

    -- Define animation and props (if any) for the progress bar
    local animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@'
    local anim = 'machinic_loop_mechandplayer'
    
    QBCore.Functions.Progressbar("deploying_bike", "Deploying Bike...", 3500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = animDict,
        anim = anim,
        flags = 49,
    }, {}, {}, function() -- Done
        ClearPedTasks(PlayerPedId())

        TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)
        TriggerEvent("QBCore:Notify", "Bike deployed!", "success")

        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")

        local bikeModel = GetHashKey("bmx")
        local pedCoords = GetEntityCoords(ped)
        local bikeCoords = vector3(pedCoords.x + 2, pedCoords.y, pedCoords.z)
        RequestModel(bikeModel)
        while not HasModelLoaded(bikeModel) do
            Wait(50)
        end

        local bike = CreateVehicle(bikeModel, bikeCoords.x, bikeCoords.y, bikeCoords.z, 0.0, true, false)
        TaskWarpPedIntoVehicle(ped, bike, -1)

        TriggerEvent('vehiclekeys:client:SetOwner', GetVehicleNumberPlateText(bike))
    end, function() -- Cancel
        ClearPedTasks(PlayerPedId())
    end)
end)

```

# Server-side (qb-smallresources):

- In qb-smallresources/server/consumables.lua, ensure the bike item is usable:
```
-- BIKE
QBCore.Functions.CreateUseableItem("bike", function(source, item) -- "bike" is the item name you'd use to spawn the bike. Replace with your item name if different.
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
    TriggerClientEvent('consumables:client:bike', source, item.name)
    end
end)
```
# Step 4: Update Your Inventory Images
- Move the provided bike.png from the [images] folder to your qb-inventory/html/images directory to ensure the bike item has an icon in the inventory.

# Final Steps
- After completing the setup, ensure all changes are saved, and restart your server to see the new Pawn Shop job and features in action. For further customization and support, join our [Discord](https://discord.com/invite/XAV4AfgQaZ).

# Remember, for the bike deployment feature to function correctly, ensure the animation and progress bar script snippets are correctly placed within the consumables:client:bike event as instructed.