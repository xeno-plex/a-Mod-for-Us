
SMODS.Joker{ --Jolt
    key = "jolt",
    config = {
        extra = {
            moneygiven = 0
        }
    },
    loc_txt = {
        ['name'] = 'Jolt',
        ['text'] = {
            [1] = 'Earn {C:gold}$5{} for the first time',
            [2] = 'a {C:red}Mult {}card is scored and',
            [3] = 'decrease amount by {C:money}$1{}',
            [4] = 'every {C:red}Mult {}card afterwards',
            [5] = '{C:inactive}(Will not go below $0){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
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
        
        return {vars = {card.ability.extra.moneygiven}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if (SMODS.get_enhancements(context.other_card)["m_mult"] == true and to_big((card.ability.extra.moneygiven or 0)) > to_big(0)) then
                local moneygiven_value = card.ability.extra.moneygiven
                if not context.blueprint  then 
                card.ability.extra.moneygiven = math.max(0, (card.ability.extra.moneygiven) - 1)
                end
                return {
                    
                    func = function()
                        
                        local current_dollars = G.GAME.dollars
                        local target_dollars = G.GAME.dollars + moneygiven_value
                        local dollar_value = target_dollars - current_dollars
                        ease_dollars(dollar_value)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(moneygiven_value), colour = G.C.MONEY})
                        return true
                    end
                }
            end
        end
        if context.after and context.cardarea == G.jokers  then
            if to_big((card.ability.extra.moneygiven or 0)) < to_big(4) then
                return {
                    message = "kzzap!"
                }
            end
        end
        if context.before and context.cardarea == G.jokers  then
            return {
                func = function()
                    card.ability.extra.moneygiven = 5
                    return true
                end
            }
        end
    end
}
