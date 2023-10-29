
Config = {}


-- ██╗░░░██╗████████╗██╗██╗░░░░░██╗████████╗██╗░░░██╗
-- ██║░░░██║╚══██╔══╝██║██║░░░░░██║╚══██╔══╝╚██╗░██╔╝
-- ██║░░░██║░░░██║░░░██║██║░░░░░██║░░░██║░░░░╚████╔╝░
-- ██║░░░██║░░░██║░░░██║██║░░░░░██║░░░██║░░░░░╚██╔╝░░
-- ╚██████╔╝░░░██║░░░██║███████╗██║░░░██║░░░░░░██║░░░
-- ░╚═════╝░░░░╚═╝░░░╚═╝╚══════╝╚═╝░░░╚═╝░░░░░░╚═╝░░░

Config.CoreName = "qb-core" -- Core name
Config.Job = "pawn" -- Job
Config.JimPayments = true -- Using jim-payments?
Config.Target = "qb-target" -- Name of your resource qb-target
Config.Input = "qb-input" -- Name of your resource qb-input
Config.InvLink = "qb-inventory/html/images/" -- Your directory images inventory
Config.Bossmenu = "qb-bossmenu:client:OpenMenu" -- Your trigger to open boss menu

-- ██████╗░██╗░░░░░██╗██████╗░
-- ██╔══██╗██║░░░░░██║██╔══██╗
-- ██████╦╝██║░░░░░██║██████╔╝
-- ██╔══██╗██║░░░░░██║██╔═══╝░
-- ██████╦╝███████╗██║██║░░░░░
-- ╚═════╝░╚══════╝╚═╝╚═╝░░░░░

Config.Blip = {
	Enable = true,
	Location = vector3(165.46, -1317.4, 25.81),
	Sprite = 267,
	Display = 2,
	Scale = 0.9,
	Colour = 5,
	Name = "Pawn Shop",
}


-- ░██████╗████████╗░█████╗░░██████╗██╗░░██╗
-- ██╔════╝╚══██╔══╝██╔══██╗██╔════╝██║░░██║
-- ╚█████╗░░░░██║░░░███████║╚█████╗░███████║
-- ░╚═══██╗░░░██║░░░██╔══██║░╚═══██╗██╔══██║
-- ██████╔╝░░░██║░░░██║░░██║██████╔╝██║░░██║
-- ╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═════╝░╚═╝░░╚═╝

Config.Stash = {
	StashInvTrigger = "inventory:client:SetCurrentStash",
	OpenInvTrigger = "inventory:server:OpenInventory",
	NameOfStash = "ps_storage",
	MaxWeighStash = 250000,
	MaxSlotsStash = 150,
}


-- ██████╗░██╗██╗░░░░░██╗░░░░░██╗███╗░░██╗░██████╗░
-- ██╔══██╗██║██║░░░░░██║░░░░░██║████╗░██║██╔════╝░
-- ██████╦╝██║██║░░░░░██║░░░░░██║██╔██╗██║██║░░██╗░
-- ██╔══██╗██║██║░░░░░██║░░░░░██║██║╚████║██║░░╚██╗
-- ██████╦╝██║███████╗███████╗██║██║░╚███║╚██████╔╝
-- ╚═════╝░╚═╝╚══════╝╚══════╝╚═╝╚═╝░░╚══╝░╚═════╝░

Config.Billing = {
	EnableCommand = false,
	Command = "billps",
}

-- ██████╗░██╗░░░██╗███╗░░██╗░██████╗
-- ██╔══██╗██║░░░██║████╗░██║██╔════╝
-- ██████╔╝██║░░░██║██╔██╗██║╚█████╗░
-- ██╔══██╗██║░░░██║██║╚████║░╚═══██╗
-- ██║░░██║╚██████╔╝██║░╚███║██████╔╝
-- ╚═╝░░╚═╝░╚═════╝░╚═╝░░╚══╝╚═════╝░

Config.RunsItems = {
    {item = 'steel', min = 1, max = 5},  -- The player can get between 1 and 5 'steel'
    {item = 'rubber', min = 2, max = 7}, -- The player can get between 2 and 7 'rubber'
    -- Add more items as needed with their respective min and max
}

Config.StartPed = {
    coords = vector3(176.53, -1317.67, 23.03), -- change as needed
    job = "pawn" -- the job needed to start the run
}


Config.DestinationPed = {
    coords = vector3(-356.19, -1487.41, 29.18) -- coordinates for destination ped, change as needed
}

-- ░█████╗░██████╗░░█████╗░███████╗████████╗░██████╗
-- ██╔══██╗██╔══██╗██╔══██╗██╔════╝╚══██╔══╝██╔════╝
-- ██║░░╚═╝██████╔╝███████║█████╗░░░░░██║░░░╚█████╗░
-- ██║░░██╗██╔══██╗██╔══██║██╔══╝░░░░░██║░░░░╚═══██╗
-- ╚█████╔╝██║░░██║██║░░██║██║░░░░░░░░██║░░░██████╔╝
-- ░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░░░░╚═╝░░░╚═════╝░

-- Crafting Items
Config.Crafting = {
    ["bike"] = { 
        hash = "bike", 
        label = "A Deployable Bike",
        materials = {
            [1] = { item = "iron",               amount = 250 },
            [2] = { item = "aluminum",           amount = 150 },
            [3] = { item = "rubber",             amount = 100 },
            [4] = { item = "steel",              amount = 100 },
        }
    },
    ["handcuffs"] = { 
        hash = "handcuffs", 
        label = "Hand Cuffs",
        materials = {
            [1] = { item = "iron",       amount = 25 },
            [2] = { item = "steel",        amount = 50 },
        }
    },
}

