
SMODS.Joker{ --xenoplex
    key = "xenoplex",
    config = {
        extra = {
            planet = 'c_pluto',
            count = 0,
            textplanet = 'Pluto',
            freeconsumableslots = 0,
            odds = 2
        }
    },
    loc_txt = {
        ['name'] = 'xenoplex',
        ['text'] = {
            [1] = 'Each {C:attention}Steel{} card held at',
            [2] = '{C:attention}end of round{} has a',
            [3] = '{C:green}#5# in #6# {}chance to',
            [4] = 'make this joker to {C:attention}fetch {}',
            [5] = 'last used {C:planet}Planet{} card',
            [6] = '{C:inactive}( Currently #3# ){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
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
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_amodforu_xenoplex') 
        return {vars = {card.ability.extra.planet, card.ability.extra.count, card.ability.extra.textplanet, (((G.consumeables and G.consumeables.config.card_limit or 0) - #(G.consumeables and G.consumeables.cards or {})) or 0), new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.using_consumeable  then
            if context.consumeable and context.consumeable.ability.set == 'Planet' then
                card.ability.extra.planet = context.consumeable.config.center.key
                local all_key_lists = {}
                for _, pool in pairs(G.P_CENTER_POOLS) do
                    for _, item in pairs(pool) do
                        table.insert(all_key_lists, item)
                    end      
                end
                for _, current_card in pairs(all_key_lists) do
                    if current_card.key == card.ability.extra.planet then
                        if current_card.set == "Seal" then
                            card.ability.extra.textplanet = current_card.key
                        else 
                            card.ability.extra.textplanet = current_card.name
                        end
                        break
                    end
                end
                return {
                    message = "BALL?"
                }
            end
        end
        if context.individual and context.cardarea == G.hand and context.end_of_round  then
            if (SMODS.get_enhancements(context.other_card)["m_steel"] == true and to_big((card.ability.extra.count or 0)) < to_big(((G.consumeables and G.consumeables.config.card_limit or 0) - #(G.consumeables and G.consumeables.cards or {})))) then
                if SMODS.pseudorandom_probability(card, 'group_0_accf529b', 1, card.ability.extra.odds, 'j_amodforu_xenoplex', false) then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound("amodforu_bark")
                            
                            return true
                        end,
                    }))
                    SMODS.calculate_effect({func = function()
                        
                        for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.4,
                                func = function()
                                    play_sound('timpani')
                                    SMODS.add_card({ key = card.ability.extra.planet})                            
                                    card:juice_up(0.3, 0.5)
                                    return true
                                end
                            }))
                        end
                        delay(0.6)
                        
                        if created_consumable then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Fetched!", colour = G.C.PURPLE})
                        end
                        return true
                    end}, card)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Fetched!", colour = G.C.GREEN})
                    SMODS.calculate_effect({func = function()
                        card.ability.extra.count = (card.ability.extra.count) + 1
                        return true
                    end}, card)
                end
            end
        end
        if context.before and context.cardarea == G.jokers  then
            return {
                func = function()
                    card.ability.extra.count = 0
                    return true
                end
            }
        end
    end
}