local debrize =
[[
{
"sub_name": "AutoDF+ Rework GUI",
"icon": "Rocket",
"menu": [
{
    "type": "labelapp",
    "icon": Bolt,
    "text": "AutoDF++ By DebrizeCH"
},
{
    "type": "label",
    "text": "AutoDF++"
},
{
    "type": "toggle",
    "text": "Start AutoDF",
    "alias": "DebrizeOnDF",
    "default": false
},
{
    "type": "label",
    "text": "Setting AutoDF++"
},
{
    "type": "divider"
},
{
    "type": "toggle",
    "text": "Break Rock",
    "alias": "DebrizeOnLava",
    "default": true
},
{
    "type": "slider",
    "text": "Delay Place",
    "alias": "DebrizeOnDelay",
    "min": 90,
    "max": 200,
    "default": 150
},
{
    "type": "slider",
    "text": "Delay Break",
    "alias": "DebrizeOnDB",
    "min": 160,
    "max": 200,
    "default": 165
},
{
    "type": "toggle",
    "text": "Enable Next World",
    "alias": "DebrizeOnNext",
    "default": false
},
{
    "type": "dialog",
    "text": "World Next",
    "support_text": "WorldNext Setting",
    "fill": true,
    "menu": [
{
 "type": "input_string",
 "text": "World 1",
 "default": "",
 "icon" : "Edit",
 "alias": "NextWorld1"
},
{
 "type": "input_string",
 "text": "World 2",
 "default": "",
 "icon" : "Edit",
 "alias": "NextWorld2"
},
{
 "type": "input_string",
 "text": "World 3",
 "default": "",
 "icon" : "Edit",
 "alias": "NextWorld3"
},
{
 "type": "input_string",
 "text": "World 4",
 "default": "",
 "icon" : "Edit",
 "alias": "NextWorld4"
},
{
 "type": "input_string",
 "text": "World 5",
 "default": "",
 "icon" : "Edit",
 "alias": "NextWorld5"
}
]
},
{
    "type": "toggle",
    "text": "Take plat wtw",
    "alias": "DebrizeOnTake",
    "default": false
},
{
    "type": "input_int",
    "text": "ItemID Plat",
    "default": "102",
    "label": "default woodplat",
    "placeholder": "DebrizeCH",
    "icon": "Loop",
    "alias": "DebrizePlat"
},
{
 "type": "input_string",
 "text": "World Take Plat",
 "default": "",
 "icon" : "Edit",
 "alias": "DebrizePlatWorld"
},
{
 "type": "input_string",
 "text": "Door ID",
 "default": "",
 "icon" : "Edit",
 "alias": "DebrizePlatID"
},
{
    "type": "input_int",
    "text": "PosX",
    "default": "38",
    "label": "Take Plat",
    "placeholder": "DebrizeCH",
    "icon": "Loop",
    "alias": "DebrizePlatX"
},
{
    "type": "input_int",
    "text": "PosY",
    "default": "20",
    "label": "Take Plat",
    "placeholder": "DebrizeCH",
    "icon": "Loop",
    "alias": "DebrizePlatY"
},
{
    "type": "divider"
},
{
    "type": "input_int",
    "text": "PosX Drop",
    "default": "38",
    "label": "Drop dirt/cave",
    "placeholder": "DebrizeCH",
    "icon": "Loop",
    "alias": "DebrizePlatX"
},
{
    "type": "input_int",
    "text": "PosY Drop",
    "default": "20",
    "label": "Drop dirt/cave",
    "placeholder": "DebrizeCH",
    "icon": "Loop",
    "alias": "DebrizePlatY"
},
{
    "type": "toggle",
    "text": "trash Dirt Seed",
    "alias": "DebrizeOnDirt",
    "default": false
},
{
    "type": "toggle",
    "text": "trash Cave Seed",
    "alias": "DebrizeOnCave",
    "default": false
}
]
}
]]
setMinimum("6.1.7")
addIntoModule(debrize)

------------------------------------------

GasDF = false
Taking = false
Pelat = 102
DebzDelay = 150
DelayB = 170
lava = true
dirt = false
cave = false
GasNext = false
WorldSave = ""
WorldSaveID = ""
PosXP = 37
PosYP = 23
PosXD = 37
PosYD = 23
WorldNext1 = ""
WorldNext2 = ""
WorldNext3 = ""
WorldNext4 = ""
WorldNext5 = ""

------------------------------------------

function inv(item)
for _, object in pairs(GetInventory()) do
if object.id == item then
return object.amount
end
end
return 0
end

function put(x, y, id)
pkt = {}
pkt.type = 3
pkt.value = id
pkt.px = GetLocal().posX // 32 + x
pkt.py = GetLocal().posY // 32 + y
pkt.x = GetLocal().posX
pkt.y = GetLocal().posY
SendPacketRaw(false, pkt)
end

function brek(x, y, id)
pkt = {}
pkt.type = 3
pkt.value = id
pkt.px = x
pkt.py = y
pkt.x = GetLocal().posX
pkt.y = GetLocal().posY
SendPacketRaw(false, pkt)
end

function collect(rx,ry)
for _, obj in pairs(GetObjectList()) do
local obx = math.abs(GetLocal().posX - obj.posX)
local oby = math.abs(GetLocal().posY - obj.posY)
if obx < rx and oby < ry then
SendPacketRaw(false, {
    type = 11,
    value = obj.id,
    x = obj.posX,
    y = obj.posY
})
Sleep(70)
end
end
end

------------------------------------------




CaveS = 15
DirtS = 3
DirtBe = 2
DirtSe = 3
DirtBL = 2
Dirtoh = 4

function trash(item, much)
SendPacket(2,"action|trash\n|itemID|"..item)
Sleep(1000)
SendPacket(2,"action|dialog_return\ndialog_name|trash_item\nitemID|"..item.."|\ncount|"..much)
Sleep(1000)
end


function dropDS(Ayam, sate)
SendPacket(2,"action|drop\n|itemID|"..Ayam)
Sleep(1000)
SendPacket(2,"action|dialog_return\ndialog_name|drop_item\nitemID|"..Ayam.."|\ncount|"..sate)
Sleep(1500)
end




---------------BREAK BAWAH-----------------
-------------------------------------------
function BerakLava()
for _, tile in pairs(GetTiles())
do
if GasDF == true then
if inv(DirtBL) > 0 then
if lava then
if (tile.fg == 4 or tile.fg == 10 or (tile.fg == 0 and tile.bg == 14)) and GetTile(tile.x, tile.y+1).fg == 0 then
Sleep(200)
FindPath(tile.x, tile.y+1)
Sleep(300)
repeat
brek(tile.x,tile.y, 18)
Sleep(DelayB+55)
until (GetTile(tile.x, tile.y).fg == 0 and GetTile(tile.x, tile.y).bg == 0)
Sleep(300)
collect(96,96)
Sleep(400)
brek(tile.x,tile.y,2)
Sleep(700)
end
elseif not lava then
if (tile.fg == 4 or (tile.fg == 0 and tile.bg == 14)) and GetTile(tile.x, tile.y+1).fg == 0 then
Sleep(200)
FindPath(tile.x, tile.y+1)
Sleep(300)
repeat
brek(tile.x,tile.y, 18)
Sleep(DelayB+55)
until (GetTile(tile.x, tile.y).fg == 0 and GetTile(tile.x, tile.y).bg == 0)
Sleep(300)
collect(96,96)
Sleep(400)
brek(tile.x,tile.y,2)
Sleep(700)
end
end
end
end
end
end

local function clamp(val, min, max)
    return math.max(min, math.min(max, val))
end

local function isTileClear(x, y)
    local t = GetTile(x, y)
    return t and t.fg == 0 and t.bg == 0
end

local function isWindowClear(centerX, y)
    for dx = -2, 2, 1 do
        local tx = clamp(centerX + dx, 0, 99)
        local t = GetTile(tx, y)
        if not (t.fg == 0 and t.bg == 0) then
            return false
        end
    end
    return true
end

local function isPlayerAt(x, y)
    local px = math.floor(GetLocal().posX / 32)
    local py = math.floor(GetLocal().posY / 32)
    return px == x and py == y
end

local function ensurePlayerAt(x, y)
    if not isPlayerAt(x, y) then
        if not FindPath(x, y) then
            Sleep(500)
        end
        Sleep(200)
    end
    return true
end

local function breakWindowUntilClear(centerX, y)
    local tries = 0
    repeat
        if not GasDF then break end
        tries = tries + 1
        if not ensurePlayerAt(centerX, y - 2) then return false end

        for dx = -2, 2, 1 do
            local tx = clamp(centerX + dx, 0, 99)
            local t = GetTile(tx, y)

            -- hanya break kalau tile ada isinya
            if t.x == tx and (t.fg ~= 0 or t.bg ~= 0) then
                brek(tx, y, 18)
                Sleep(DelayB)
            end
        end

        if tries > 30 then return false end
    until isWindowClear(centerX, y)
    return true
end

local function breakTileUntilClear(x, y)
    local tries = 0
    repeat
        tries = tries + 1
        if not ensurePlayerAt(x, y - 2) then return false end

            local t = GetTile(x, y)

            -- hanya break kalau tile ada isinya
            if t.x == x and (t.fg ~= 0 or t.bg ~= 0) then
                brek(x, y, 18)
                Sleep(DelayB)
            end
        if tries > 25 then return false end
    until isTileClear(x, y)
    return true
end

function testdoang()
    local visited = {}
    for _, tile in pairs(GetTiles()) do
        if not GasDF then break end
        if inv(DirtS) >= 35 or inv(CaveS) >= 200 then goto continue end

        if not ((tile.fg == 2) or (tile.bg == 14 and tile.fg == 0) or (tile.fg == 10) or (tile.fg == 4)) then
            goto continue
        end

        local breakPinggir = (tile.x <= 1) or (tile.x >= 98)
        visited[tile.y] = visited[tile.y] or {}

        if breakPinggir then
            if visited[tile.y][tile.x] then goto continue end
            if tile.y % 2 ~= 1 then
                Sleep(300)
                if not FindPath(tile.x, tile.y - 2) then
                    Sleep(150)
                    collect(150, 64) 
                    Sleep(DelayB+10)
                    if breakTileUntilClear(tile.x, tile.y) then
                        BerakLava()
                    end
                end
            else
                Sleep(200)
                if not FindPath(tile.x+2, tile.y - 2) then
                    local startX = math.floor(tile.x / 5) * 5
                    local centerX = startX + 2
                    Sleep(100)
                    collect(150, 64) 
                    Sleep(100)
                    if breakWindowUntilClear(centerX, tile.y) then
                        BerakLava()
                    end
                end
            end
            visited[tile.y][tile.x] = true
        else
            if tile.y % 2 ~= 1 then goto continue end
            local startX = math.floor(tile.x / 5) * 5
            local centerX = startX + 2
            if visited[tile.y][startX] then goto continue end
            Sleep(200)
            if not FindPath(centerX, tile.y - 2) then
                Sleep(100)
                collect(100, 64) 
                Sleep(100)
                if breakWindowUntilClear(centerX, tile.y) then
                    BerakLava()
                end
            end
            visited[tile.y][startX] = true
        end

        ::continue::
    end
end


-------------------------------------------
---------------PLACE ATAS------------------
-------------------------------------------
function placee()
for _, tile in pairs(GetTiles()) do
if not GasDF then break end
for ps = 2, 97 do
if (tile.y %2 == 0) and (tile.x == ps) and (tile.y ~= 0) then
if (tile.fg == 0) then
if inv(DirtBL) >= 5 then
Sleep(150)
FindPath(ps, tile.y-1)
Sleep(DebzDelay)
put(0, 1, 2)
Sleep(DebzDelay)
end
end
end
end
end
end



function checkTiles()
for _, tile in pairs(GetTiles()) do
if (tile.y % 2 == 0) and (tile.x ~= 0 and tile.x ~= 1 and tile.x ~= 98 and tile.x ~= 99) and (tile.y ~= 0) then
if tile.fg == 0 then
return false -- Ada tile dengan fg == 0
end
end
end
return true -- Tidak ada tile dengan fg == 0
end

function checkDone()
for _, tile in pairs(GetTiles()) do
if (tile.y % 2 == 1 and tile.fg == 2 or tile.fg == 4) then
return false -- Ada tile dengan fg == 0
end
end
return true -- Tidak ada tile dengan fg == 0
end


function harvest()
for _, tile in pairs(GetTiles()) do
if not GasDF then break end
if (tile.fg == 3) and (tile.readyharvest == true) then
if inv(DirtBL) <= 150 then
Sleep(150)
if not FindPath(tile.x, tile.y) then
Sleep(150)
put(0, 0, 18)
Sleep(DelayB)
collect(100,100)
end
end
end
end
end


function pelant()
for _, tile in pairs(GetTiles()) do
if not GasDF then break end
for x = 2, 15 do
if tile.fg == 0 and (tile.y == 1 or tile.y == 23) and tile.x == x and GetTile(tile.x, tile.y + 1).fg ~= 0 and GetTile(tile.x, tile.y + 1).fg % 2 == 0 then
local targetTile = GetTile(x, tile.y)
if targetTile.fg == 0 then
if inv(DirtBL) < 100 and inv(DirtS) >= 10 then
Sleep(160)
if not FindPath(tile.x, tile.y) then
Sleep(200)
put(0, 0, 3)
Sleep(200)
end
end
end
end
end
end
end



function dropdirt()
if inv(DirtS) >= 35 or inv(DirtBL) > 99 then
local kurangi = inv(DirtBL) - 60
if not dirt then
Sleep(300)
FindPath(PosXD, PosYD)
Sleep(1500)
if not checkTiles() then
log("`0[`2DebrizeCH`0] Dropping Dirt Block : "..math.floor(inv(DirtBL)/3))
dropDS(DirtBL, math.floor(inv(DirtBL)/3))
Sleep(2000)
elseif checkTiles() then
if kurangi > 1 then
log("`0[`2DebrizeCH`0] Dropping Dirt Block : "..math.floor(kurangi))
dropDS(DirtBL, math.floor(kurangi))
Sleep(2000)
end
end
log("`0[`2DebrizeCH`0] Dropping Dirt Seed : "..inv(DirtS))
dropDS(DirtS, inv(DirtS))
Sleep(2000)
elseif dirt then
log("`0[`2DebrizeCH`0] Trashing Dirt Seed : "..inv(DirtS))
trash(DirtS, inv(DirtS))
Sleep(1500)
log("`0[`2DebrizeCH`0] Trashing Dirt block : "..inv(DirtBL))
trash(DirtBL, inv(DirtBL))
Sleep(1500)
end
end
end

function dropcave()
if inv(CaveS) == 200 then
if not cave then
log("`0[`2DebrizeCH`0] Dropping Cave bg : "..inv(14))
Sleep(300)
FindPath(PosXD, PosYD)
Sleep(1500)
dropDS(14, inv(14))
Sleep(2000)
log("`0[`2DebrizeCH`0] Dropping Cave seed : "..inv(CaveS))
dropDS(CaveS, inv(CaveS))
Sleep(2000)
log("`0[`2DebrizeCH`0] Dropping Rock seed : "..inv(11))
dropDS(11, inv(11))
Sleep(2000)
log("`0[`2DebrizeCH`0] Dropping Lava seed : "..inv(5))
dropDS(5, inv(5))
Sleep(2000)

elseif cave then
log("`0[`2DebrizeCH`0] Trashing Cave seed : "..inv(CaveS))
trash(CaveS, inv(CaveS))
Sleep(2000)
log("`0[`2DebrizeCH`0] Trashing Cave bg : "..inv(CaveS))
trash(14, inv(14))
Sleep(2000)
log("`0[`2DebrizeCH`0] Trashing Rock seed : "..inv(11))
trash(11, inv(11))
Sleep(2000)
log("`0[`2DebrizeCH`0] Trashing Lava seed : "..inv(5))
trash(5, inv(5))
Sleep(2000)
end
end
end

-------------------------------------------
-------------------------------------------
------------PLACE PLATFORM-----------------
-------------------------------------------

function placeeplat()
for _, tile in pairs(GetTiles()) do
    if not GasDF then return end
    -- Kalau stok pelat habis, ambil dulu
    if inv(Pelat) <= 0 then
        if not Taking then return end
        LogToConsole("`0[`2DebrizeCH`0] Starting Take Plat")
        growtopia.warpTo(WorldSave.."|"..WorldSaveID)
        -- Tunggu sampai benar-benar sudah masuk ke world target
        repeat
            if not GasDF then return end
            if WorldSave == "" then return end
            Sleep(1500)
            LogToConsole("`0[`2DebrizeCH`0] Waiting take plat to: "..WorldSave)
        until GetWorldName() == string.upper(WorldSave)
        Sleep(2500)
        FindPath(PosXP, PosYP)
        Sleep(1000)
        growtopia.sendChat("/b", true)
        Sleep(2500)
elseif inv(Pelat) > 0 then
if (tile.y % 2 == 0) and (tile.fg == 0) and (tile.y ~= 0) and (tile.y ~= 1) then
if (tile.x == 1) or (tile.x == 98) then
FindPath(tile.x, tile.y + 1)
Sleep(500)
put(0, 1, Pelat)
Sleep(500)
put(0, -1, Pelat)
Sleep(500)
end
end
end
end
end

-------------------------------------------

EditToggle("ModFly", true)
EditToggle("Antibounce", true)
EditToggle("Antilag", true)

function main()
if GasDF then
if GetWorldName() == "EXIT" then return end
if not checkDone() then
if not checkTiles() then
if inv(DirtBL) < 100 and inv(DirtS) < 35 and inv(CaveS) < 200 and inv(CaveS+1) < 200 then
log("`0[`2DebrizeCH`0] Starting Auto DF")
Sleep(2500)
testdoang()
Sleep(1500)
elseif inv(DirtBL) >= 100 or inv(DirtS) >= 35 then
log("`0[`2DebrizeCH`0] Starting Auto Place")
placee()
Sleep(2500)
log("`0[`2DebrizeCH`0] Starting Auto Plant")
pelant()
Sleep(1500)
log("`0[`2DebrizeCH`0] Starting Auto Harvest")
harvest()
Sleep(1500)
elseif inv(CaveS) == 200 or inv(CaveS+1) == 200 then
log("`0[`2DebrizeCH`0] Starting Drop Cave")
dropcave()
log("`0[`2DebrizeCH`0] Starting Drop Dirt")
dropdirt()
Sleep(1500)
end
elseif checkTiles() then
if inv(DirtBL) < 100 and inv(DirtS) < 35 and inv(CaveS) < 200 and inv(CaveS+1) < 200 then
log("`0[`2DebrizeCH`0] Starting DF")
Sleep(2500)
testdoang()
Sleep(1500)
log("`0[`2DebrizeCH`0] Starting AutoPlat")
placeeplat()
Sleep(1500)
elseif inv(DirtBL) >= 100 or inv(DirtS) >= 35 then
log("`0[`2DebrizeCH`0] Starting Drop Dirt")
dropdirt()
Sleep(1500)
log("`0[`2DebrizeCH`0] Starting Harvest")
harvest()
Sleep(1500)
elseif inv(CaveS) == 200 or inv(CaveS+1) == 200 then
log("`0[`2DebrizeCH`0] Starting Drop Cave")
dropcave()
log("`0[`2DebrizeCH`0] Starting Drop Dirt")
dropdirt()
Sleep(1500)
end
end
elseif checkDone() then
if checkTiles() then
if GasNext then
local WorldNext = {
    WorldNext1, WorldNext2, WorldNext3, WorldNext4, WorldNext5
}
for _, world in ipairs(WorldNext) do
if GetWorldName() ~= string.upper(world) then
log("`0[`2DebrizeCH`0] Done! Start Next World")
Sleep(2000)
growtopia.warpTo(world)
Sleep(2000)
repeat
if not GasNext then return end
if not GasDF then return end
if world == "" then 
log("`0[`2DebrizeCH`0] All world done!")
return end
Sleep(2000)
LogToConsole("`0[`2DebrizeCH`0] Waiting Warp to: "..world)
until GetWorldName() == string.upper(world)
Sleep(1500)
end
log("`0[`2DebrizeCH`0] Starting Drop Cave")
dropcave()
log("`0[`2DebrizeCH`0] Starting Drop Dirt")
dropdirt()
Sleep(1500)
log("`0[`2DebrizeCH`0] Now in world: " .. world)
log("`0[`2DebrizeCH`0] Checking World DF")
Sleep(2000)
testdoang()
Sleep(1500)
BerakLava()
log("`0[`2DebrizeCH`0] Checking Tile")
Sleep(1500)
placee()
log("`0[`2DebrizeCH`0] Checking Tree")
Sleep(2500)
harvest()
log("`0[`2DebrizeCH`0] Checking Plat")
Sleep(2000)
placeeplat()
Sleep(3500)
log("`0[`2DebrizeCH`0] DF Done!")
if not checkDone() or not checkTiles() then return end
end
elseif not GasNext then
log("`0[`2DebrizeCH`0] Starting Drop Cave")
dropcave()
log("`0[`2DebrizeCH`0] Starting Drop Dirt")
dropdirt()
Sleep(1500)
log("`0[`2DebrizeCH`0] Checking world DF!")
testdoang()
Sleep(2000)
BerakLava()
log("`0[`2DebrizeCH`0] Checking Tile")
Sleep(1500)
placee()
log("`0[`2DebrizeCH`0] Checking Tree")
Sleep(2500)
harvest()
log("`0[`2DebrizeCH`0] Checking Plat")
Sleep(1500)
placeeplat()
Sleep(1500)
log("`0[`2DebrizeCH`0] Auto DF Done!")
Sleep(5000)
return end
end
end
end
end




---

function AvoidError()
if not pcall(main) then
if not GasDF then return end
LogToConsole("`0[`9DebrizeCH`0]`4You dc! Back to World")
Sleep(1000)
LogToConsole("`0[`9DebrizeCH`0]`4Waiting..")
Sleep(2500)
AvoidError()
end
end

runThread(function()
    while true do
    if GasDF then
    AvoidError()
    else
        Sleep(2000)
    end
    end
    end)


function onValue(type, name, value)
if type == 0 and name == "DebrizeOnDF" then
GasDF = value
end
if type == 0 and name == "DebrizeOnNext" then
GasNext = value
end
if type == 0 and name == "DebrizeOnTake" then
Taking = value
end

if type == 5 and name == "NextWorld1" then
WorldNext1 = string.upper(value)
end
if type == 5 and name == "NextWorld2" then
WorldNext2 = string.upper(value)
end
if type == 5 and name == "NextWorld3" then
WorldNext3 = string.upper(value)
end
if type == 5 and name == "NextWorld4" then
WorldNext4 = string.upper(value)
end
if type == 5 and name == "NextWorld5" then
WorldNext5 = string.upper(value)
end
if type == 5 and name == "DebrizePlatWorld" then
WorldSave = string.upper(value)
end
if type == 5 and name == "DebrizePlatID" then
WorldSaveID = value
end
if type == 1 and name == "DebrizePlatX" then
PosXP = value
end
if type == 1 and name == "DebrizePlatY" then
PosYP = value
end
if type == 1 and name == "DebrizeDropX" then
PosXD = value
end
if type == 1 and name == "DebrizeDropY" then
PosYD = value
end
if type == 0 and name == "DebrizeOnDirt" then
dirt = value
end
if type == 0 and name == "DebrizeOnLava" then
lava = value
end
if type == 0 and name == "DebrizeOnCave" then
cave = value
end
if type == 1 and name == "DebrizeOnDelay" then
DebzDelay = value
end
if type == 1 and name == "DebrizeOnDB" then
DelayB = value
end
if type == 1 and name == "DebrizePlat" then
Pelat = value
end
if type == 0 and name == "DebrizeOnCoor" then
kordinat()
end
end

function variantlist(var)
if not GasDF then return end
if var.v1 == "OnDialogRequest" then
if var.v2:find("drop") and (var.v2:find("2") or var.v2:find("3") or var.v2:find("5") or var.v2:find("11") or var.v2:find("14") or var.v2:find("15")) then
return true
end
end
return false
end

var = {}
var.v1 = "OnTextOverlay"
var.v2 = "`2DEBRIZE`4SC"


AddHook(variantlist, "OnVariant")
applyHook()
SendVariant(var)
log("`2Auto DF Rework By `bDebrizeCH")
---