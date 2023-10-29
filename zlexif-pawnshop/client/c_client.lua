local QBCore = exports['qb-core']:GetCoreObject()

----------------------------------------------------
--------- Blips
----------------------------------------------------
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

----------------------------------------------------
--------- Events
----------------------------------------------------

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local player = QBCore.Functions.GetPlayerData()
    PlayerJob = player.job
    onDuty = player.job.onduty
end)

RegisterNetEvent('zlexif-pawn:Client:Notify')
AddEventHandler("zlexif-pawn:Client:Notify", function(msg,type)
    Notify(msg,type)
end)

AddEventHandler("zlexif-pawn:Client:Storage", function()
    TriggerEvent(Config.Stash.StashInvTrigger, Config.Stash.NameOfStash)
    TriggerServerEvent(Config.Stash.OpenInvTrigger, "stash", Config.Stash.NameOfStash, {
        maxweight = Config.Stash.MaxWeighStash,
        slots = Config.Stash.MaxSlotsStash,
    })
end)

AddEventHandler("zlexif-pawn:Client:OpenTray01", function()
    TriggerEvent(Config.Stash.StashInvTrigger, "Tray01")
    TriggerServerEvent(Config.Stash.OpenInvTrigger, "stash", "Tray01", {
        maxweight = 5000,
        slots = 10,
    })
end)

AddEventHandler("zlexif-pawn:Client:OpenTray02", function()
    TriggerEvent(Config.Stash.StashInvTrigger, "Tray02")
    TriggerServerEvent(Config.Stash.OpenInvTrigger, "stash", "Tray02", {
        maxweight = 5000,
        slots = 10,
    })
end)

AddEventHandler("zlexif-pawn:Client:OpenTray03", function()
    TriggerEvent(Config.Stash.StashInvTrigger, "Tray03")
    TriggerServerEvent(Config.Stash.OpenInvTrigger, "stash", "Tray03", {
        maxweight = 5000,
        slots = 10,
    })
end)

AddEventHandler("zlexif-pawn:Client:OpenTray04", function()
    TriggerEvent(Config.Stash.StashInvTrigger, "Tray04")
    TriggerServerEvent(Config.Stash.OpenInvTrigger, "stash", "Tray04", {
        maxweight = 5000,
        slots = 10,
    })
end)

RegisterNetEvent("zlexif-pawn:Client:OpenShop", function(index)
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "shop", {
        label = "shop",
        items = Config.Items,
        slots = #Config.Items,
    })
end);

AddEventHandler('zlexif-pawn:Client:Sit', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"sitchair"})
end)
-- || ===============> Invoice
 
RegisterNetEvent('zlexif-pawn:Client:Invoicing', function()
    if Config.JimPayments then
        TriggerEvent("jim-payments:client:Charge", Config.Job)
    else
        local dialog = exports[Config.Input]:ShowInput({
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

if Config.Billing.EnableCommand then
    if Config.JimPayments then
        TriggerEvent("jim-payments:client:Charge", Config.Job)
    else
        RegisterCommand(Config.Billing.Command, function()
            local dialog = exports[Config.Input]:ShowInput({
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
        end)
    end
end

local destinationPed = nil
local pedSpawned = false
local isRunActive = false
local runTimer = 180 -- 3 minutes (expressed in seconds for convenience)
local destinationBlip = nil  -- Initialized at the top of your script


-- Function to spawn the destination ped
function SpawnDestinationPed()
    local destPed = Config.DestinationPed.coords
    local pedHash = GetHashKey("a_m_y_business_01") --  ped model for destination
    RequestModel(pedHash)
    while not HasModelLoaded(pedHash) do
        Wait(1)
    end

    destinationPed = CreatePed(0, pedHash, destPed.x, destPed.y, destPed.z, 95.5, false, true)
    FreezeEntityPosition(destinationPed, true)
    SetEntityInvincible(destinationPed, true)
    SetBlockingOfNonTemporaryEvents(destinationPed, true)

    -- Add destination blip
    -- Add destination blip
    destinationBlip = AddBlipForCoord(destPed.x, destPed.y, destPed.z) 
    SetBlipSprite(destinationBlip, 1) -- adjust as needed
    SetBlipColour(destinationBlip, 5) -- adjust as needed
    SetBlipRoute(destinationBlip, true)

    exports['qb-target']:AddTargetModel({pedHash}, {
        options = {
            {
                event = "zlexif-runs:completeRun",
                icon = "fas fa-box",
                label = "Complete run",
            }
        },
        job = Config.StartPed.job, -- restrict to the same job
        distance = 1.5
    })
end

Citizen.CreateThread(function()
    local startPed = Config.StartPed.coords
    local pedHash = GetHashKey("a_m_y_business_03") -- example ped model
    RequestModel(pedHash)
    while not HasModelLoaded(pedHash) do
        Wait(1)
    end

    local createdPed = CreatePed(0, pedHash, startPed.x, startPed.y, startPed.z, 157.3, false, true)
    FreezeEntityPosition(createdPed, true)
    SetEntityInvincible(createdPed, true)
    SetBlockingOfNonTemporaryEvents(createdPed, true)

    -- If using qb-target, you would establish the targeting options here
    exports['qb-target']:AddTargetModel({pedHash}, {
        options = {
            {
                event = "zlexif-runs:startRun",
                icon = "fas fa-running",
                label = "Start run",
            }
        },
        job = Config.StartPed.job, -- only allow certain jobs to interact
        distance = 1.5
    })
end)

-- Event to handle the run start
RegisterNetEvent('zlexif-runs:startRun')
AddEventHandler('zlexif-runs:startRun', function()
    if not pedSpawned and not isRunActive then  -- Ensure the run isn't already active
        local Player = QBCore.Functions.GetPlayerData()
        if Player.job.name == Config.StartPed.job then
            SpawnDestinationPed()
            pedSpawned = true
            isRunActive = true  -- Mark the run as active

            -- ADD A NOTIFICATION HERE TO INDICATE THE RUN HAS STARTED
            QBCore.Functions.Notify('Run has started, you have 3 minutes to complete!', 'success', 5000)

            -- Start the timer and display the persistent notification
            Citizen.CreateThread(function()
                while isRunActive and runTimer > 0 do
                    Citizen.Wait(1000) -- wait 1 second before continuing the loop
                    runTimer = runTimer - 1

                    -- Here you would put the code to display the timer. This is a placeholder:
                    QBCore.Functions.Notify('Time left: ' .. runTimer .. ' seconds', 'primary', 1000)
                end

                if runTimer <= 0 then
                    isRunActive = false
                    runTimer = 180 -- reset the timer
            
                    -- Add this check here too, to remove the blip when the time is up
                    if destinationBlip ~= nil then
                        RemoveBlip(destinationBlip)
                        destinationBlip = nil
                    end
                    if DoesEntityExist(destinationPed) then
                        DeleteEntity(destinationPed)
                        destinationPed = nil
                        pedSpawned = false
                    end
                    QBCore.Functions.Notify('You failed to complete the run on time!', 'error', 5000)
                end
            end)
    else
        QBCore.Functions.Notify('You do not have the required job', 'error', 5000)
    end
elseif isRunActive then
    QBCore.Functions.Notify('You are already on a run!', 'error', 5000)
else
    QBCore.Functions.Notify('A destination ped is already spawned', 'error', 5000)
end
end)



-- Event to handle the run completion
RegisterNetEvent('zlexif-runs:completeRun')
AddEventHandler('zlexif-runs:completeRun', function()
    if isRunActive and runTimer > 0 then  -- Check if the run is still active and there's time left
        -- Iterate over each item in the configuration
        for _, rewardItem in pairs(Config.RunsItems) do
            -- Generate a random number between the minimum and maximum
            local quantity = math.random(rewardItem.min, rewardItem.max)

            -- Trigger server event to reward the player; pass both the item and the quantity
            TriggerServerEvent('zlexif-runs:reward', rewardItem.item, quantity) 
        end

        -- Cleanup and reset
        if destinationBlip ~= nil then -- Check if there's a blip to remove
            RemoveBlip(destinationBlip) -- Remove the blip using the stored ID from the destinationBlip variable
            destinationBlip = nil -- Clear the stored blip ID
        end
        if DoesEntityExist(destinationPed) then
            DeleteEntity(destinationPed)
            destinationPed = nil
            pedSpawned = false
        end

        isRunActive = false
        runTimer = 180 -- Reset the timer for the next run
        QBCore.Functions.Notify('You have received your items', 'success', 5000)
    else
        QBCore.Functions.Notify('No active run or run has already ended.', 'error', 5000)
    end
end)






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

function Craft(weapon)
    QBCore.Functions.Progressbar('Craft', Language.Progressbars.Make..Config.Crafting[weapon].label, 5000, false, false, {
        disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true,
    }, { animDict = "mini@repair", anim = "fixing_a_ped", }, {}, {}, function()
        Notify(Language.Notify.Make..Config.Crafting[weapon].label, 'success', 5000)
        TriggerServerEvent('zlexif-pawn:server:Craft', Config.Crafting[weapon].hash)
        for k, v in pairs(Config.Crafting[weapon].materials) do
             TriggerServerEvent('zlexif-pawn:Server:RemoveItem', v.item, v.amount)
             TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[v.item], "remove")
        end
        ClearPedTasks(PlayerPedId())
    end, function() -- Cancel
        ClearPedTasks(PlayerPedId())
        Notify(Language.Notify.Canceled, 'error', 6000)
    end)
end

RegisterNetEvent('zlexif-pawn:client:Craft', function(data)
    QBCore.Functions.TriggerCallback("zlexif-pawn:server:Materials", function(hasMaterials)
        if (hasMaterials) then
            Craft(data.type)
        else
            Notify(Language.Notify.NoMaterials, 'error', 6000)
            return
        end
    end, Config.Crafting[data.type].materials)
end)