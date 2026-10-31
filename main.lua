SMODS.Atlas({
    key = "modicon", 
    path = "ModIcon.png", 
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "balatro", 
    path = "balatro.png", 
    px = 333,
    py = 216,
    prefix_config = { key = false },
    atlas_table = "ASSET_ATLAS"
})


SMODS.Atlas({
    key = "CustomJokers", 
    path = "CustomJokers.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomDecks", 
    path = "CustomDecks.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

local NFS = require("nativefs")
to_big = to_big or function(a) return a end
lenient_bignum = lenient_bignum or function(a) return a end
-- this function is used to load everything within a folder.-- Jokerforge doesnt use it because it doesnt make loading order easy
local function load_folder(path)
    local files = NFS.getDirectoryItemsInfo(mod_path .. "/" .. path)
    for i = 1, #files do
        local file_name = files[i].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file(path .. file_name))()
        end
    end
end
-- load the jokers
if true then
    assert(SMODS.load_file("jokers/stardust.lua"))()
    assert(SMODS.load_file("jokers/anxiety.lua"))()
    assert(SMODS.load_file("jokers/notorious.lua"))()
    assert(SMODS.load_file("jokers/xenoplex.lua"))()
    assert(SMODS.load_file("jokers/lis.lua"))()
    assert(SMODS.load_file("jokers/jolt.lua"))()
    assert(SMODS.load_file("jokers/silverfrost.lua"))()
    assert(SMODS.load_file("jokers/fren.lua"))()
    assert(SMODS.load_file("jokers/bris.lua"))()
    assert(SMODS.load_file("jokers/agent42.lua"))()
    assert(SMODS.load_file("jokers/blizzardskarn.lua"))()
    assert(SMODS.load_file("jokers/coldcat.lua"))()
    assert(SMODS.load_file("jokers/vaporeon.lua"))()
    assert(SMODS.load_file("jokers/mikuberry.lua"))()
    assert(SMODS.load_file("jokers/kyuriaisu.lua"))()
end
-- load the decks
if true then
    assert(SMODS.load_file("decks/eeveelution_deck.lua"))()
    assert(SMODS.load_file("decks/bootleg_knox_deck.lua"))()
end

--load sounds
assert(SMODS.load_file("sounds.lua"))()
SMODS.ObjectType({
    key = "amodforu_food",
    cards = {
        ["j_gros_michel"] = true,
        ["j_egg"] = true,
        ["j_ice_cream"] = true,
        ["j_cavendish"] = true,
        ["j_turtle_bean"] = true,
        ["j_diet_cola"] = true,
        ["j_popcorn"] = true,
        ["j_ramen"] = true,
        ["j_selzer"] = true
    },
})

SMODS.ObjectType({
    key = "amodforu_friend",
    cards = {
        ["j_amodforu_stardust"] = true,
        ["j_amodforu_anxiety"] = true,
        ["j_amodforu_notorious"] = true,
        ["j_amodforu_xenoplex"] = true,
        ["j_amodforu_lis"] = true,
        ["j_amodforu_jolt"] = true,
        ["j_amodforu_silverfrost"] = true,
        ["j_amodforu_fren"] = true,
        ["j_amodforu_bris"] = true,
        ["j_amodforu_agent42"] = true,
        ["j_amodforu_blizzardskarn"] = true,
        ["j_amodforu_coldcat"] = true,
        ["j_amodforu_vaporeon"] = true,
        ["j_amodforu_mikuberry"] = true,
        ["j_amodforu_kyuriaisu"] = true
    },
})

SMODS.ObjectType({
    key = "amodforu_cheese",
    cards = {
        ["j_amodforu_anxiety"] = true,
        ["j_amodforu_notorious"] = true
    },
})


SMODS.current_mod.optional_features = function()
    return {
        cardareas = {} 
    }
end