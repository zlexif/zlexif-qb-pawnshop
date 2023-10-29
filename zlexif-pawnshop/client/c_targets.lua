local QBCore = exports['qb-core']:GetCoreObject()

----------------------------------------------------
--------- TARGETS
----------------------------------------------------

-- || ===============> Stash
exports[Config.Target]:AddBoxZone("StashPS",vector3(168.1, -1315.55, 29.34), 2, 2, 
    { name="StashPS", heading = 330, debugPoly = false, minZ = 26.74, maxZ = 30.74 }, 
    { options = { {  event = "zlexif-pawn:Client:Storage", icon = "fas fa-box", label = "Stash", job = Config.Job }, },  distance = 2.0 })
-- || ===============> Stash 2
exports[Config.Target]:AddBoxZone("StashPS2", vector3(169.85, -1312.55, 29.34), 2.5, 2.5, 
    { name="StashPS2", heading = 65, debugPoly = false, minZ = 26.74, maxZ = 30.74 }, 
    { options = { {  event = "zlexif-pawn:Client:Storage", icon = "fas fa-box", label = "Stash", job = Config.Job }, },  distance = 2.0 })
    -- || ===============> Stash 3  - COPY THIS FORMAT IF U WANT TO CREATE MORE STASHES. MAKE SURE TO CREATE A POLYZONE FIRST.
--exports[Config.Target]:AddBoxZone("BLANK", vector3(0, 0, 0), 0, 0, 
--{ name="BLANK", heading = 0, debugPoly = false, minZ = 0, maxZ = 0 }, 
--{ options = { {  event = "zlexif-pawn:Client:Storage", icon = "fas fa-box", label = "Stash", job = Config.Job }, },  distance = 2.0 })
 -- || ===============> Crafting
 exports[Config.Target]:AddBoxZone("Crafting",vector3(164.78, -1323.83, 25.81), 1, 4, 
 { name="Crafting", heading = 335, debugPoly = false, minZ = 23.21, maxZ = 27.21 }, 
 { options = { {   action = function() CraftMenu() end, icon = "fa-solid fa-hammer", label = "Craft", job = Config.Job }, },  distance = 2.0 })

-- || ===============> Billing 
exports[Config.Target]:AddBoxZone("Billing", vector3(173.69, -1317.68, 29.35), 0.7, 0.7, 
   { name="Billing", heading = 345, debugPoly = false, minZ = 25.95, maxZ = 29.95 }, 
    { options = { {   event = "zlexif-pawn:Client:Invoicing", icon = "fa-solid fa-money-bill", label = "Bill", job = Config.Job }, },  distance = 2.0 })
-- || ===============> Billing2 -- COPY THIS FORMAT IF U WANT TO CREATE MORE BILLING PLACES. MAKE SURE TO CREATE A POLYZONE FIRST.
--exports[Config.Target]:AddBoxZone("Billing2", vector3(0.0, 0.0, 0.0), 0.0, 0.0, 
  --  { name="Billing2", heading = 0, debugPoly = false, minZ = 0.0, maxZ = 0.0 }, 
   -- { options = { {   event = "zlexif-pawn:Client:Invoicing", icon = "fa-solid fa-money-bill", label = "Bill", job = Config.Job }, },  distance = 2.0 })
-- || ===============> Duty
exports[Config.Target]:AddBoxZone("Duty", vector3(93.82, -1294.53, 29.26), 1, 3, 
    { name="Duty", heading = 300, debugPoly = false, minZ = 26.26, maxZ = 30.26 }, 
    { options = { {   action = function() Duty() end, icon = "fa-solid fa-clipboard-list", label = "Duty", job = Config.Job }, },  distance = 2.0 })
    -- || ===============> Duty
-- exports[Config.Target]:AddBoxZone("Duty", vector3(0.0, 0.0, 0.0), 0, 0, 
-- { name="Duty", heading = 0, debugPoly = false, minZ = 0.0, maxZ = 0.0 }, 
-- { options = { {   action = function() Duty() end, icon = "fa-solid fa-clipboard-list", label = "Duty", job = Config.Job }, },  distance = 2.0 })

-- || ===============> BossMenu
exports[Config.Target]:AddBoxZone("BossMenu", vector3(165.83, -1317.44, 29.34), 1, 2.5, 
    { name="BossMenu", heading = 335, debugPoly = false, minZ = 26.14, maxZ = 30.14 }, 
    { options = { {  event = "qb-bossmenu:client:OpenMenu", icon = "fa-solid fa-clipboard-list", label = "Boss Menu", job = Config.Job }, },  distance = 2.0 })
-- || ===============> Tray01
 exports[Config.Target]:AddBoxZone("Tray01", vector3(175.89, -1324.02, 29.35), 1, 7, 
    { name="Tray01", heading = 155, debugPoly = false, minZ = 25.75, maxZ = 29.75 }, 
    { options = { {  event = "zlexif-pawn:Client:OpenTray01", icon = "fa-solid fa-clipboard-list", label = "Tray" }, },  distance = 2.0 })
-- || ===============> Tray02 -- COPY THIS FORMAT IF YOU WANT TO ADD MORE TRAYS, MAKE SURE YOU CREATE THE POLYZONE FIRST.
--exports[Config.Target]:AddBoxZone("Tray02", vector3(0, 0, 0), 0, 0, 
  --  { name="Tray02", heading = 0, debugPoly = false, minZ = 0, maxZ = 0 }, 
  --  { options = { {  event = "zlexif-pawn:Client:OpenTray02", icon = "fa-solid fa-clipboard-list", label = "Tray" }, },  distance = 2.0 })
-- || ===============> Clothing
exports[Config.Target]:AddBoxZone("Wardrobe", vector3(167.5, -1318.78, 29.34), 1, 1, 
    { name="Wardrobe", heading = 330, debugPoly = false, minZ = 25.94, maxZ = 29.94 }, 
    { options = { {  event = "qb-clothing:client:openOutfitMenu", icon = "fa-solid fa-clipboard-list", label = "Wardrobe", job = Config.Job }, },  distance = 2.0 })
    -- || ===============> Clothing 2
-- exports[Config.Target]:AddBoxZone("Wardrobe", vector3(0.0, 0.0, 0.0), 0, 0, 
-- { name="Wardrobe", heading = 0, debugPoly = false, minZ = 0.0, maxZ = 0.0 }, 
-- { options = { {  event = "qb-clothing:client:openOutfitMenu", icon = "fa-solid fa-clipboard-list", label = "Wardrobe", job = Config.Job }, },  distance = 2.0 })