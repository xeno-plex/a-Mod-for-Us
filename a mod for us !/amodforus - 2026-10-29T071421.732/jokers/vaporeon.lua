
SMODS.Joker{ --Vaporeon
    key = "vaporeon",
    config = {
        extra = {
            slot_change = '1',
            odds = 4
        }
    },
    loc_txt = {
        ['name'] = 'Vaporeon',
        ['text'] = {
            [1] = '{C:attention}+1{} Consumable Slot'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amodforu_friend"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_amodforu_vaporeon') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.using_consumeable  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_d653a086', 1, card.ability.extra.odds, 'j_amodforu_vaporeon', true) then
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = ":wave:", colour = G.C.BLUE})
                end
            end
        end
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
            return true
        end }))
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
            return true
        end }))
    end
}