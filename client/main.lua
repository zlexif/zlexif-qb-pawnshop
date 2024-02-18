local QBCore = exports['qb-core']:GetCoreObject()
local currentStashKey = nil
local destinationPed = nil
local pedSpawned = false
local isRunActive = false
local runTimer = Config.RunTimerDuration 
local destinationBlip = nil  

function Duty()
    TriggerServerEvent("QBCore:ToggleDuty")
end

CreateThread(function()
    if Config.Blip.Enable then
        local blip = AddBlipForCoord(Config.Blip.Location) 
        SetBlipSprite(blip, Config.Blip.Sprite) 
        SetBlipDisplay(blip, Config.Blip.Display)
        SetBlipScale(blip, Config.Blip.Scale)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, Config.Blip.Colour)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Blip.Name) 
        EndTextCommandSetBlipName(blip)
    end
end)


AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local player = QBCore.Functions.GetPlayerData()
    PlayerJob = player.job
    onDuty = player.job.onduty
end)

function CustomNotify(msg, type, length)
    if Config.Notifications == "ps" then
        exports['ps-ui']:Notify(msg, type, length)
    elseif Config.Notifications == "qb" then
        QBCore.Functions.Notify(msg, type, length)
    elseif Config.Notifications == "k5" then
        exports["k5_notify"]:notify(type, msg, type, length)
    else
        print("Invalid notification type specified in Config.")
    end
end

RegisterNetEvent('zlexif-pawn:Client:CustomNotify', function(msg, type, length)
    CustomNotify(msg, type, length)
end)


for stashKey, stashConfig in pairs(Config.Stashes) do
        exports[Config.Target]:AddBoxZone(stashConfig.stashName, stashConfig.coords, stashConfig.length, stashConfig.width, {
            name = stashConfig.stashName,
            heading = stashConfig.heading,
            debugPoly = false,
            minZ = stashConfig.minZ,
            maxZ = stashConfig.maxZ
    }, {
        options = {
            {
                event = "zlexif-pawn:client:openStash",
                icon = "fas fa-box",
                label = "Open Stash",
                job = Config.Job,
                action = function() 
                    currentStashKey = stashKey
                    TriggerEvent("zlexif-pawn:client:openStash")
                end
            }
        },
        distance = 2.5
    })
end

exports[Config.Target]:AddBoxZone(
    Config.DutyZone.name,
    Config.DutyZone.coords,
    Config.DutyZone.size.x,
    Config.DutyZone.size.y,
    {
        name = Config.DutyZone.name,
        heading = Config.DutyZone.heading,
        debugPoly = Config.DutyZone.debugPoly,
        minZ = Config.DutyZone.minZ,
        maxZ = Config.DutyZone.maxZ
    },
    {
        options = Config.DutyZone.options,
        distance = Config.DutyZone.distance
    }
)

exports[Config.Target]:AddBoxZone(
    Config.WardrobeZone.name,
    Config.WardrobeZone.coords,
    Config.WardrobeZone.size.x,
    Config.WardrobeZone.size.y,
    {
        name = Config.WardrobeZone.name,
        heading = Config.WardrobeZone.heading,
        debugPoly = Config.WardrobeZone.debugPoly,
        minZ = Config.WardrobeZone.minZ,
        maxZ = Config.WardrobeZone.maxZ
    },
    {
        options = Config.WardrobeZone.options,
        distance = Config.WardrobeZone.distance
    }
)

exports[Config.Target]:AddBoxZone(
    Config.BossMenuZone.name,
    Config.BossMenuZone.coords,
    Config.BossMenuZone.size.x,
    Config.BossMenuZone.size.y,
    {
        name = Config.BossMenuZone.name,
        heading = Config.BossMenuZone.heading,
        debugPoly = Config.BossMenuZone.debugPoly,
        minZ = Config.BossMenuZone.minZ,
        maxZ = Config.BossMenuZone.maxZ
    },
    {
        options = Config.BossMenuZone.options,
        distance = Config.BossMenuZone.distance
    }
)

exports[Config.Target]:AddBoxZone(Config.CraftingZone.name, Config.CraftingZone.coords, Config.CraftingZone.length, Config.CraftingZone.width, 
    { 
        name = Config.CraftingZone.name, 
        heading = Config.CraftingZone.heading, 
        debugPoly = false, 
        minZ = Config.CraftingZone.minZ, 
        maxZ = Config.CraftingZone.maxZ 
    }, 
    { 
        options = Config.CraftingZone.options, 
        distance = Config.CraftingZone.distance 
    }
)

exports[Config.Target]:AddBoxZone(Config.BillingZone.name, Config.BillingZone.coords, Config.BillingZone.length, Config.BillingZone.width, 
    { 
        name = Config.BillingZone.name, 
        heading = Config.BillingZone.heading, 
        debugPoly = false, 
        minZ = Config.BillingZone.minZ, 
        maxZ = Config.BillingZone.maxZ 
    }, 
    { 
        options = Config.BillingZone.options, 
        distance = Config.BillingZone.distance 
    }
)

RegisterNetEvent('zlexif-pawn:client:openStash', function()
    local playerJob = QBCore.Functions.GetPlayerData().job
    if currentStashKey then
        local stashConfig = Config.Stashes[currentStashKey]

        if stashConfig then
            if stashConfig.jobrequired and playerJob.name == Config.Job then
                if Config.InventorySystem == "qb-inventory" then
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", stashConfig.stashName, {
                        maxweight = stashConfig.stashSize, 
                        slots = stashConfig.stashSlots
                    })
                    TriggerEvent("inventory:client:SetCurrentStash", stashConfig.stashName)
                elseif Config.InventorySystem == "qs-inventory" then
                    exports['qs-inventory']:OpenStash(stashConfig.stashName, stashConfig.stashSlots, stashConfig.stashSize)
                end
            else
                CustomNotify('You do not have permission to access this stash.', 'error', 5000)
                end
        else
            CustomNotify('Stash configuration not found.', 'error', 5000)
        end
    end
end)

RegisterNetEvent("zlexif-pawn:Client:OpenShop", function(index)
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "shop", {
        label = "shop",
        items = Config.Items,
        slots = #Config.Items,
    })
end);

 
RegisterNetEvent('zlexif-pawn:Client:Invoicing', function()
    if Config.JimPayments then
        TriggerEvent("jim-payments:client:Charge", Config.Job)
    else
        local dialog = exports["qb-input"]:ShowInput({
            header = Language.Input.Header,
            submitText = Language.Input.Submit,
            inputs = {
                { type = 'number', isRequired = true, name = 'id', text = Language.Input.Paypal },
                { type = 'number', isRequired = true, name = 'amount', text = Language.Input.Amount }
            }
        })
        if dialog then
            if not dialog.id or not dialog.amount then return end
            TriggerServerEvent("zlexif-pawn:Server:Billing", dialog.id, dialog.amount)
        end
    end
end)


function SpawnDestinationPed()
    local destPed = Config.DestinationPed.coords
    local pedHash = GetHashKey("a_m_y_business_01") 
    RequestModel(pedHash)
    while not HasModelLoaded(pedHash) do
        Wait(1)
    end

    destinationPed = CreatePed(0, pedHash, destPed.x, destPed.y, destPed.z, 95.5, false, true)
    FreezeEntityPosition(destinationPed, true)
    SetEntityInvincible(destinationPed, true)
    SetBlockingOfNonTemporaryEvents(destinationPed, true)



    destinationBlip = AddBlipForCoord(destPed.x, destPed.y, destPed.z) 
    SetBlipSprite(destinationBlip, 1) 
    SetBlipColour(destinationBlip, 5) 
    SetBlipRoute(destinationBlip, true)

    exports['qb-target']:AddTargetModel({pedHash}, {
        options = {
            {
                event = "zlexif-runs:completeRun",
                icon = "fas fa-box",
                label = "Complete run",
            }
        },
        job = Config.StartPed.job, 
        distance = 1.5
    })
end

Citizen.CreateThread(function()
    local startPed = Config.StartPed.coords
    local pedHash = GetHashKey("a_m_y_business_03") 
    RequestModel(pedHash)
    while not HasModelLoaded(pedHash) do
        Wait(1)
    end

    local createdPed = CreatePed(0, pedHash, startPed.x, startPed.y, startPed.z, 157.3, false, true)
    FreezeEntityPosition(createdPed, true)
    SetEntityInvincible(createdPed, true)
    SetBlockingOfNonTemporaryEvents(createdPed, true)

    exports['qb-target']:AddTargetModel({pedHash}, {
        options = {
            {
                event = "zlexif-runs:startRun",
                icon = "fas fa-running",
                label = "Start run",
            },
            {
                event = "zlexif-runs:endRun",
                icon = "fas fa-stop-circle",
                label = "End run",
            }
        },
        job = Config.StartPed.job, 
        distance = 1.5
    })
end)

RegisterNetEvent('zlexif-runs:startRun')
AddEventHandler('zlexif-runs:startRun', function()
    if not pedSpawned and not isRunActive then  
        local Player = QBCore.Functions.GetPlayerData()
        if Player.job.name == Config.StartPed.job then
            SpawnDestinationPed()
            pedSpawned = true
            isRunActive = true
            runTimer = Config.RunTimerDuration  

            CustomNotify(Language.Notify.RunStarted, 'success', 5000)

            Citizen.CreateThread(function()
                while isRunActive and runTimer > 0 do
                    exports['ps-ui']:DisplayText('Time left: ' .. runTimer .. ' seconds', 'primary')
                    Citizen.Wait(1000) 
                    runTimer = runTimer - 1
                end
                exports['ps-ui']:HideText()  

                if runTimer <= 0 then
                    isRunActive = false
                    if destinationBlip ~= nil then
                        RemoveBlip(destinationBlip)
                        destinationBlip = nil
                    end
                    if DoesEntityExist(destinationPed) then
                        DeleteEntity(destinationPed)
                        destinationPed = nil
                        pedSpawned = false
                    end
                    CustomNotify(Language.Notify.RunFailedTime, 'error', 5000)
                end
            end)
        else
            CustomNotify(Language.Notify.NoRequiredJob, 'error', 5000)
        end
    elseif isRunActive then
        CustomNotify(Language.Notify.AlreadyOnRun, 'error', 5000)
    else
        CustomNotify(Language.Notify.PedAlreadySpawned, 'error', 5000)
    end
end)

RegisterNetEvent('zlexif-runs:endRun')
AddEventHandler('zlexif-runs:endRun', function()
    if isRunActive then
        if destinationBlip ~= nil then
            RemoveBlip(destinationBlip)
            destinationBlip = nil
        end
        if DoesEntityExist(destinationPed) then
            DeleteEntity(destinationPed)
            destinationPed = nil
            pedSpawned = false
        end

        isRunActive = false
        runTimer = Config.RunTimerDuration  
        exports['ps-ui']:HideText()  

        CustomNotify(Language.Notify.RunEnded, 'primary', 5000)
    else
        CustomNotify(Language.Notify.NoActiveRunToEnd, 'error', 5000)  
    end
end)



RegisterNetEvent('zlexif-runs:completeRun')
AddEventHandler('zlexif-runs:completeRun', function()
    if isRunActive and runTimer > 0 then  
        for _, rewardItem in pairs(Config.RunsItems) do
            local quantity = math.random(rewardItem.min, rewardItem.max)
            TriggerServerEvent('zlexif-runs:reward', rewardItem.item, quantity) 
        end

        if destinationBlip ~= nil then 
            RemoveBlip(destinationBlip) 
            destinationBlip = nil 
        end
        if DoesEntityExist(destinationPed) then
            DeleteEntity(destinationPed)
            destinationPed = nil
            pedSpawned = false
        end

        isRunActive = false
        runTimer = Config.RunTimerDuration 
        CustomNotify(Language.Notify.ItemsReceived, 'success', 5000)
    else
        CustomNotify(Language.Notify.NoActiveRun, 'error', 5000)
    end
end)


exports['qb-target']:AddBoxZone("BreakerZone", Config.BreakerZone.coords, Config.BreakerZone.length, Config.BreakerZone.width, {
    name = "BreakerZone",
    heading = Config.BreakerZone.heading,
    debugPoly = false,
    minZ = Config.BreakerZone.minZ,
    maxZ = Config.BreakerZone.maxZ,
}, {
    options = {
        {
            event = "zlexif-pawn:client:OpenBreakerMenu",
            icon = Config.BreakerZone.icon,
            label = Config.BreakerZone.label,
        }
    },
    distance = Config.BreakerZone.distance
})



RegisterNetEvent('zlexif-pawn:client:OpenBreakerMenu', function()
    local menuItems = {
        { header = "Item Breakdown Station", isMenuHeader = true },
        { header = "Select an Item to Break Down", txt = "Choose an item to convert it into materials", isMenuHeader = true }
    }

    local sortedItems = {}
    for itemKey, breakdownData in pairs(Config.BreakerItems) do
        local itemInfo = QBCore.Shared.Items[itemKey]
        local itemLabel = itemInfo and itemInfo.label or "Unknown Item"
        local itemImage = itemInfo and itemInfo.image or "default.png" 

        table.insert(sortedItems, { key = itemKey, label = itemLabel, image = itemImage, breakdownData = breakdownData })
    end

    table.sort(sortedItems, function(a, b) return a.label < b.label end)

    for _, item in ipairs(sortedItems) do
        local breakdownText = "Get materials: "
        for _, matData in ipairs(item.breakdownData) do
            local materialLabel = QBCore.Shared.Items[matData.material] and QBCore.Shared.Items[matData.material].label or "Unknown Material"
            breakdownText = breakdownText .. "\n" .. matData.amount .. " " .. materialLabel
        end

        table.insert(menuItems, {
            header = "<img src=nui://" .. Config.InvLink .. item.image .. " width=35px style='margin-right: 10px'> " .. item.label,
            txt = breakdownText,
            params = {
                event = "zlexif-pawn:client:BreakItem",
                args = {
                    item = item.key,
                    breakdownData = item.breakdownData
                }
            }
        })
    end

    table.insert(menuItems, { header = "Close", txt = "", params = { event = "qb-menu:closeMenu" } })
    exports['qb-menu']:openMenu(menuItems)
end)

RegisterNetEvent('zlexif-pawn:client:BreakItem', function(data)
    local itemLabel = QBCore.Shared.Items[data.item] and QBCore.Shared.Items[data.item].label or "Unknown Item"
    QBCore.Functions.TriggerCallback('zlexif-pawn:server:HasItem', function(hasItem)
        if hasItem then
            StartBreakdownProcess(data)
        else
            CustomNotify(Language.Notify.NoMaterials, 'error', 6000)
        end
    end, data.item)
end)

function StartBreakdownProcess(data)
    local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
    local animName = "machinic_loop_mechandplayer"
    local itemLabel = QBCore.Shared.Items[data.item] and QBCore.Shared.Items[data.item].label or "Unknown Item"

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(10)
    end

    TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, -8.0, -1, 49, 0, false, false, false)
    QBCore.Functions.Progressbar("breaking_item", "Breaking down " .. itemLabel .. "...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('zlexif-pawn:server:BreakItem', data.item, data.breakdownData)
        ClearPedTasks(PlayerPedId())  
        CustomNotify(getSuccessMessage(data.item, data.breakdownData), "success", 5000)
    end, function() -- Cancel
        CustomNotify(Language.Notify.Cancelled, 'error', 5000)
        ClearPedTasks(PlayerPedId())  
    end)
end

function getSuccessMessage(item, breakdownData)
    local itemLabel = QBCore.Shared.Items[item] and QBCore.Shared.Items[item].label or "Unknown Item"
    local message = "Broke down " .. itemLabel .. " and received:"

    for _, matData in ipairs(breakdownData) do
        local materialLabel = QBCore.Shared.Items[matData.material] and QBCore.Shared.Items[matData.material].label or "Unknown Material"
        message = message .. "\n" .. matData.amount .. " " .. materialLabel
    end

    return message
end


function CraftMenu()
    local columns = { { header = Language.Menu.Craft, isMenuHeader = true, }, }
    for k, v in pairs(Config.Crafting) do
        local item = {}
        item.header = "<img src=nui://"..Config.InvLink..QBCore.Shared.Items[v.hash].image.." width=35px style='margin-right: 10px'> " .. v.label
        local text = Language.Menu.Required.." <br>"
        for k, v in pairs(v.materials) do
            text = text .. "- " .. QBCore.Shared.Items[v.item].label .. ": " .. v.amount .. "<br>"
        end
        item.text = text
        item.params = { event = 'zlexif-pawn:client:Craft', args = { type = k } }
        table.insert(columns, item)
    end
    exports['qb-menu']:openMenu(columns)
end

function Craft(craftItem)
    local function proceedWithCrafting()
        QBCore.Functions.Progressbar('Craft', Language.Progressbars.Make..Config.Crafting[craftItem].label, 15000, false, false, {
            disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true,
        }, { animDict = "mini@repair", anim = "fixing_a_ped", }, {}, {}, function()
            CustomNotify(Language.Notify.Made..Config.Crafting[craftItem].label, 'success', 5000)
            TriggerServerEvent('zlexif-pawn:server:Craft', Config.Crafting[craftItem].hash, Config.Crafting[craftItem].materials)
            ClearPedTasks(PlayerPedId())
        end, function() -- Cancel
            ClearPedTasks(PlayerPedId())
            CustomNotify(Language.Notify.Cancelled, 'error', 6000)
        end)
    end
    if Config.CraftingSettings.UseMinigame then
        if Config.CraftingSettings.MinigameType == 'Circle' then
            exports['ps-ui']:Circle(function(success)
                if success then proceedWithCrafting() else print("Minigame failed") end
            end, 2, 20)
        elseif Config.CraftingSettings.MinigameType == 'Maze' then
            exports['ps-ui']:Maze(function(success)
                if success then proceedWithCrafting() else print("Minigame failed") end
            end, 20)
        elseif Config.CraftingSettings.MinigameType == 'VarHack' then
            exports['ps-ui']:VarHack(function(success)
                if success then proceedWithCrafting() else print("Minigame failed") end
            end, 2, 3)
        elseif Config.CraftingSettings.MinigameType == 'Thermite' then
            exports['ps-ui']:Thermite(function(success)
                if success then proceedWithCrafting() else print("Minigame failed") end
            end, 10, 5, 3)
        else
            print("Invalid Minigame Type Configured.")
        end
    else
        proceedWithCrafting()
    end
end



RegisterNetEvent('zlexif-pawn:client:Craft', function(data)
    QBCore.Functions.TriggerCallback("zlexif-pawn:server:Materials", function(hasMaterials)
        if (hasMaterials) then
            Craft(data.type)
        else
            CustomNotify(Language.Notify.NoMaterials, 'error', 6000)
            return
        end
    end, Config.Crafting[data.type].materials)
end)


exports['qb-target']:AddBoxZone("MoneyWashZone", Config.MoneyWashZone.coords, Config.MoneyWashZone.length, Config.MoneyWashZone.width, {
    name = "MoneyWashZone",
    heading = Config.MoneyWashZone.heading,
    debugPoly = false,
    minZ = Config.MoneyWashZone.minZ,
    maxZ = Config.MoneyWashZone.maxZ,
}, {
    options = {
        {
            event = "zlexif-pawn:client:OpenMoneyWashMenu",
            icon = Config.MoneyWashZone.icon,
            label = Config.MoneyWashZone.label,
        }
    },
    distance = Config.MoneyWashZone.distance
})

RegisterNetEvent('zlexif-pawn:client:OpenMoneyWashMenu', function()
    local dialog = exports['qb-input']:ShowInput({
        header = "Money Wash",
        submitText = "Start Washing",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = 'Amount of marked bills to wash'
            }
        }
    })

    if dialog then
        if not dialog.amount or tonumber(dialog.amount) <= 0 then
            CustomNotify(Language.Notify.InvalidAmountEntered, 'error', 5000)
        else
            TriggerEvent('zlexif-pawn:client:StartMoneyWash', tonumber(dialog.amount))
        end
    end
end)

RegisterNetEvent('zlexif-pawn:client:StartMoneyWash', function(amount)
    QBCore.Functions.TriggerCallback('zlexif-pawn:server:HasMarkedBills', function(hasBills, billsAmount)
        if hasBills and amount <= billsAmount then
            local playerPed = PlayerPedId()
            local animDict = "anim@heists@ornate_bank@grab_cash"
            local animName = "grab"
            RequestAnimDict(animDict)
            while not HasAnimDictLoaded(animDict) do
                Citizen.Wait(10)
            end
            TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 50, 0, false, false, false)

            QBCore.Functions.Progressbar("washing_money", "Washing money...", 20000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                ClearPedTasks(playerPed)
                TriggerServerEvent('zlexif-pawn:server:WashMoney', amount)
                CustomNotify(Language.Notify.MoneyLaunderingComplete, 'success', 5000)
            end, function() -- Cancel
                ClearPedTasks(playerPed)
                CustomNotify(Language.Notify.Cancelled, 'error', 5000)
            end)
        else
            CustomNotify(Language.Notify.NotEnoughMarkedBills, 'error', 5000)
        end
    end, amount)
end)


exports['qb-target']:AddBoxZone("BedZone", vector3(167.66, -1312.48, 24.82), 2.6, 1.5, {
    name="BedZone",
    heading= 335,
    debugPoly= false,
    minZ= 22.41,
    maxZ= 26.41
}, {
    options = {
        {
            event = "zlexif-pawn:client:UseBed",
            icon = "fas fa-bed",
            label = "Rest on Bed",
        }
    },
    distance = 2.5
})


RegisterNetEvent('zlexif-pawn:client:UseBed', function()
    local playerPed = PlayerPedId()
    local bedCoords = vector3(167.66, -1312.48, 24.82)
    local bedHeading = 63.13

    TaskGoStraightToCoord(playerPed, bedCoords.x, bedCoords.y, bedCoords.z, 1.0, 5000, bedHeading, 0.2)
    Citizen.Wait(2000) 

    local animDict = "missfbi5ig_0"
    local animName = "lyinginpain_loop_steve"
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(10)
    end
    TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 1, 0, false, false, false)

    QBCore.Functions.Progressbar("sleeping", "Resting...", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        ClearPedTasks(playerPed)
        TriggerServerEvent('zlexif-pawn:server:RelieveStress')
        CustomNotify(Language.Notify.RestAndStressFree, 'success', 5000)
    end, function() -- Cancel
        ClearPedTasks(playerPed)
        CustomNotify(Language.Notify.Cancelled, 'error', 5000)
    end)
end)


exports['qb-target']:AddBoxZone("StashLocker", vector3(174.22, -1319.19, 24.03), 0.8, 2.0, {
    name = "StashLocker",
    heading = 65,
    debugPoly = false,
    minZ = 21.03,
    maxZ = 25.03,
}, {
    options = {
        {
            event = "zlexif-pawn:client:OpenStashMenu",
            icon = "fas fa-box",
            label = "Open Stash Locker",
        }
    },
    distance = 2.0
})


RegisterNetEvent('zlexif-pawn:client:OpenStashMenu', function()
    local dialog = exports['qb-input']:ShowInput({
        header = "Enter Locker Number",
        submitText = "Open",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'lockerNumber',
                text = 'Locker Number (1-999)'
            }
        }
    })

    if dialog then
        if not dialog.lockerNumber then return end
        local lockerNumber = tonumber(dialog.lockerNumber)
        if lockerNumber and lockerNumber >= 1 and lockerNumber <= 999 then
            local stashName = "locker_" .. lockerNumber
            local lockerConfig = Config.SpecificLockers and Config.SpecificLockers[lockerNumber] or Config.Lockers
            TriggerEvent("inventory:client:SetCurrentStash", stashName)
            TriggerServerEvent("inventory:server:OpenInventory", "stash", stashName, {
                maxweight = lockerConfig.MaxWeight,  
                slots = lockerConfig.Slots           
            })
        else
            CustomNotify(Language.Notify.InvalidLockerNumber, 'error', 5000)
        end
    end
end)
