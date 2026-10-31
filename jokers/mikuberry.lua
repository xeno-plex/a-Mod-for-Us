
SMODS.Joker{ --Mikuberry
    key = "mikuberry",
    config = {
        extra = {
            amount = 0,
            jokercount = 0,
            consumablesheld = 0
        }
    },
    loc_txt = {
        ['name'] = 'Mikuberry',
        ['text'] = {
            [1] = 'Earn {C:money}$1{} for every',
            [2] = 'other {C:attention}Joker {}and',
            [3] = '{C:attention}Consumable {}held at',
            [4] = 'the end of round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amodforu_friend"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.amount, #(G.jokers and (G.jokers and G.jokers.cards or {}) or {}), (#(G.consumeables and G.consumeables.cards or {}) or 0)}}
    end, 
    
    calc_dollar_bonus = function(self, card)
        local blind_reward = 0
        blind_reward = blind_reward + math.max(card.ability.extra.amount, 0)
        if blind_reward > 0 then
            return blind_reward
        end
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
            return {
                message = "bark :3"
            }
        end
        if context.before and context.cardarea == G.jokers  then
            local amount_value = card.ability.extra.amount
            return {
                func = function()
                    card.ability.extra.amount = #(G.jokers and G.jokers.cards or {})
                    return true
                end,
                extra = {
                    func = function()
                        card.ability.extra.amount = (card.ability.extra.amount) + #(G.consumeables and G.consumeables.cards or {})
                        return true
                    end,
                    colour = G.C.GREEN,
                    extra = {
                        func = function()
                            card.ability.extra.amount = math.max(0, (card.ability.extra.amount) - 1)
                            return true
                        end,
                        colour = G.C.RED
                    }
                }
            }
        end
    end
}