
SMODS.Joker{ --BRIS
    key = "bris",
    config = {
        extra = {
            mult0 = 9
        }
    },
    loc_txt = {
        ['name'] = 'BRIS',
        ['text'] = {
            [1] = 'Each played {C:attention}9{} gives',
            [2] = '{C:red}+9{} Mult when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amodforu_friend"] = true },
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:get_id() == 9 then
                return {
                    mult = 9,
                    extra = {
                        message = "alola!",
                        colour = G.C.YELLOW
                    }
                }
            end
        end
    end
}