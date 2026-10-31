
SMODS.Joker{ --Lis 
    key = "lis",
    config = {
        extra = {
            xmult0 = 1.5
        }
    },
    loc_txt = {
        ['name'] = 'Lis ',
        ['text'] = {
            [1] = 'Other {C:attention}Jokers{} from',
            [2] = '{C:purple}a mod for US{}',
            [3] = 'each get a hug!',
            [4] = '{C:inactive}(they also give {X:red,C:white}X1.5{} {C:inactive}Mult{}){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 4,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amodforu_friend"] = true },
    
    calculate = function(self, card, context)
        if context.other_joker  then
            if (context.other_joker.config.center.key == "j_amodforu_xenoplex" or context.other_joker.config.center.key == "j_amodforu_stardust" or context.other_joker.config.center.key == "j_amodforu_anxiety" or context.other_joker.config.center.key == "j_amodforu_notorious" or context.other_joker.config.center.key == "j_amodforu_jolt" or context.other_joker.config.center.key == "j_amodforu_silverfrost" or context.other_joker.config.center.key == "j_amodforu_fren" or context.other_joker.config.center.key == "j_amodforu_bris" or context.other_joker.config.center.key == "j_amodforu_agent42" or context.other_joker.config.center.key == "j_amodforu_blizzardskarn" or context.other_joker.config.center.key == "j_amodforu_coldcat" or context.other_joker.config.center.key == "j_amodforu_vaporeon" or context.other_joker.config.center.key == "j_amodforu_mikuberry" or context.other_joker.config.center.key == "j_amodforu_kyuriaisu") then
                return {
                    Xmult = 1.5,
                    message = "hugged!"
                }
            end
        end
    end
}