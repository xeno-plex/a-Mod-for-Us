
SMODS.Joker{ --FREN
    key = "fren",
    config = {
        extra = {
            acti = 'ACTIVE!',
            mult0 = 25
        }
    },
    loc_txt = {
        ['name'] = 'FREN',
        ['text'] = {
            [1] = '{C:red}+25{} Mult every',
            [2] = 'other hand',
            [3] = '{C:inactive}#1# {}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amodforu_friend"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.acti}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if card.ability.extra.acti == 'ACTIVE!' then
                return {
                    mult = 25,
                    message = "FRIEND!"
                }
            end
        end
        if context.after and context.cardarea == G.jokers and not context.blueprint then
            if card.ability.extra.acti == 'ACTIVE!' then
                card.ability.extra.acti = 'INACTIVE!'
            elseif card.ability.extra.acti == 'INACTIVE!' then
                card.ability.extra.acti = 'ACTIVE!'
            end
        end
    end
}