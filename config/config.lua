
Config = {}


-- ██╗░░░██╗████████╗██╗██╗░░░░░██╗████████╗██╗░░░██╗
-- ██║░░░██║╚══██╔══╝██║██║░░░░░██║╚══██╔══╝╚██╗░██╔╝
-- ██║░░░██║░░░██║░░░██║██║░░░░░██║░░░██║░░░░╚████╔╝░
-- ██║░░░██║░░░██║░░░██║██║░░░░░██║░░░██║░░░░░╚██╔╝░░
-- ╚██████╔╝░░░██║░░░██║███████╗██║░░░██║░░░░░░██║░░░
-- ░╚═════╝░░░░╚═╝░░░╚═╝╚══════╝╚═╝░░░╚═╝░░░░░░╚═╝░░░
Config.Notifications = "k5"  -- Options: "ps", "qb", or "k5"
Config.Job = "pawn" -- Job
Config.Target = "qb-target" -- supports ox_target / qb-target / qtarget
Config.InvLink = "qb-inventory/html/images/"
Config.InventorySystem = "qb-inventory"  -- Options: "qb-inventory" or "qs-inventory"


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
Config.Stashes = {
    ["stash1"] = {
        stashName = "stash1",
        coords = vector3(168.1, -1315.55, 29.34),
        jobrequired = true,
        stashSize = 1000000,
        stashSlots = 125,
        heading = 320,
        length = 2.0,
        width = 2.0,
        minZ = 26.74,
        maxZ = 30.74,
    },
    ["stash2"] = {
        stashName = "stash2",
        coords = vector3(169.85, -1312.55, 29.34),
        jobrequired = true,
        stashSize = 1250000,
        stashSlots = 125,
        heading = 65,
        length = 2.5,
        width = 2.5,
        minZ = 26.74,
        maxZ = 30.74,
    },
    -- Add more stashes here with same format
}

Config.Lockers = {
    MaxWeight = 100000,  
    Slots = 30          
}

Config.CraftingZone = {
    name = "Crafting",
    coords = vector3(164.78, -1323.83, 25.81),
    length = 1,
    width = 4,
    heading = 335,
    minZ = 23.21,
    maxZ = 27.21,
    options = {
        {
            action = function() CraftMenu() end,
            icon = "fa-solid fa-hammer",
            label = "Craft",
            job = Config.Job
        }
    },
    distance = 2.0
}

Config.BillingZone = {
    name = "Billing",
    coords = vector3(173.69, -1317.68, 29.35),
    length = 0.7,
    width = 0.7,
    heading = 345,
    minZ = 25.95,
    maxZ = 29.95,
    options = {
        {
            event = "zlexif-pawn:Client:Invoicing",
            icon = "fa-solid fa-money-bill",
            label = "Bill",
            job = Config.Job
        }
    },
    distance = 2.0
}

Config.WardrobeZone = {
    name = "Wardrobe",
    coords = vector3(167.5, -1318.78, 29.34),
    size = { x = 1, y = 1 },
    heading = 330,
    debugPoly = false,
    minZ = 25.94,
    maxZ = 29.94,
    options = {
        {
            event = "qb-clothing:client:openOutfitMenu",
            icon = "fa-solid fa-clipboard-list",
            label = "Wardrobe",
            job = Config.Job
        }
    },
    distance = 2.0
}

Config.DutyZone = {
    name = "Duty",
    coords = vector3(93.82, -1294.53, 29.26),
    size = { x = 1.0, y = 3.0 },
    heading = 300,
    debugPoly = false,
    minZ= 26.26,
    maxZ= 30.26,
    options = {
        {
            action = function() Duty() end,
            icon = "fa-solid fa-clipboard-list",
            label = "Duty",
            job = Config.Job
        }
    },
    distance = 2.0
}

Config.BossMenuZone = {
    name = "BossMenu",
    coords = vector3(165.83, -1317.44, 29.34),
    size = { x = 1, y = 2.5 },
    heading = 335,
    debugPoly = false,
    minZ = 26.14,
    maxZ = 30.14,
    options = {
        {
            event = "qb-bossmenu:client:OpenMenu",
            icon = "fa-solid fa-clipboard-list",
            label = "Boss Menu",
            job = Config.Job
        }
    },
    distance = 2.0
}

Config.MoneyWashZone = {
    coords = vector3(169.69, -1313.84, 25.81),  
    length = 1.4,
    width = 2.5,
    heading = 65,
    minZ = 22.21,  
    maxZ = 26.21,   
    label = "Wash Money",
    icon = "fas fa-money-bill-wave",
    distance = 2.0
}

-- ██████╗░██╗██╗░░░░░██╗░░░░░██╗███╗░░██╗░██████╗░
-- ██╔══██╗██║██║░░░░░██║░░░░░██║████╗░██║██╔════╝░
-- ██████╦╝██║██║░░░░░██║░░░░░██║██╔██╗██║██║░░██╗░
-- ██╔══██╗██║██║░░░░░██║░░░░░██║██║╚████║██║░░╚██╗
-- ██████╦╝██║███████╗███████╗██║██║░╚███║╚██████╔╝
-- ╚═════╝░╚═╝╚══════╝╚══════╝╚═╝╚═╝░░╚══╝░╚═════╝░
Config.JimPayments = true -- if using [jim-payments](https://github.com/jimathy/jim-payments) set to true , otherwise set it to false

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
    coords = vector3(176.53, -1317.67, 23.03), 
    job = Config.Job -- the job needed to start the run
}

Config.RunTimerDuration = 90  -- Duration in seconds

Config.DestinationPed = {
    coords = vector3(-356.19, -1487.41, 29.18) -- coordinates for destination npc
}

-- ░█████╗░██████╗░░█████╗░███████╗████████╗░██████╗
-- ██╔══██╗██╔══██╗██╔══██╗██╔════╝╚══██╔══╝██╔════╝
-- ██║░░╚═╝██████╔╝███████║█████╗░░░░░██║░░░╚█████╗░
-- ██║░░██╗██╔══██╗██╔══██║██╔══╝░░░░░██║░░░░╚═══██╗
-- ╚█████╔╝██║░░██║██║░░██║██║░░░░░░░░██║░░░██████╔╝
-- ░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░░░░╚═╝░░░╚═════╝░

Config.BreakerItems = {
    ["weapon_bat"] = {
        { material = "steel", amount = 10 },
        { material = "iron", amount = 5 }
        -- Add more materials if needed
    },
    ["weapon_bottle"] = {
        { material = "plastic", amount = 3 },
        { material = "iron", amount = 2 }
        -- Add more materials if needed
    },    
    -- Add more items here
}
Config.BreakerZone = {
    coords = vector3(168.13, -1322.65, 25.81),  
    length = 0.8,
    width = 3.0,  
    heading = 65,
    minZ = 23.01,  
    maxZ = 27.01,  
    label = "Use Breaker",
    icon = "fas fa-hammer",
    distance = 2.0
}


Config.CraftingSettings = {
    UseMinigame = true,  -- Set to false to disable minigames for crafting
    MinigameType = 'Circle',  -- Options: 'Circle', 'Maze', 'VarHack', 'Thermite'
}

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

