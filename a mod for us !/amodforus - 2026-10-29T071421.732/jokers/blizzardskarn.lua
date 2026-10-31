
SMODS.Joker{ --Blizzard / Skarn
    key = "blizzardskarn",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Blizzard / Skarn',
        ['text'] = {
            [1] = 'All playing cards',
            [2] = '{C:attention}cannot be debuffed{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amodforu_friend"] = true },

    calculate = function(self, card, context)
        if context.debuff_card then
            return {
                prevent_debuff = true
            }
        end
    end
}