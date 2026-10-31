
SMODS.Joker{ --Stardust
    key = "stardust",
    config = {
        extra = {
            jokers = 0,
            jokercount = 0,
            repetitions = 3
        }
    },
    loc_txt = {
        ['name'] = 'Stardust',
        ['text'] = {
            [1] = 'When {C:attention}Blind {}is selected,',
            [2] = 'consume {C:attention}Joker {}to the',
            [3] = 'left and create 3',
            [4] = 'random {C:attention}Tags{}',
            [5] = '{C:inactive}(Bypasses Eternal)'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["modprefix_friend"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.jokers, #(G.jokers and (G.jokers and G.jokers.cards or {}) or {})}}
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind  then
            return {
                func = function()
                    card.ability.extra.jokers = #(G.jokers and G.jokers.cards or {})
                    return true
                end,
                extra = {
                    func = function()
                        local my_pos = nil
                        for i = 1, #G.jokers.cards do
                            if G.jokers.cards[i] == card then
                                my_pos = i
                                break
                            end
                        end
                        local target_joker = nil
                        if my_pos and my_pos > 1 then
                            local joker = G.jokers.cards[my_pos - 1]
                            if true and not joker.getting_sliced then
                                target_joker = joker
                            end
                        end
                        
                        if target_joker then
                            if target_joker.ability.eternal then
                                target_joker.ability.eternal = nil
                            end
                            target_joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Consumed.", colour = G.C.RED})
                        end
                        return true
                    end,
                    colour = G.C.RED
                }
            }
        end
        if context.first_hand_drawn and not context.blueprint then
            if to_big((card.ability.extra.jokers or 0)) > to_big(#(G.jokers and G.jokers.cards or {})) then
                for i = 1, 3 do
                    SMODS.calculate_effect({func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local selected_tag = pseudorandom_element(G.P_TAGS, pseudoseed("create_tag")).key
                                local tag = Tag(selected_tag)
                                if tag.name == "Orbital Tag" then
                                    local _poker_hands = {}
                                    for k, v in pairs(G.GAME.hands) do
                                        if v.visible then
                                            _poker_hands[#_poker_hands + 1] = k
                                        end
                                    end
                                    tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                                end
                                tag:set_ability()
                                add_tag(tag)
                                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                                return true
                            end
                        }))
                        return true
                    end}, card)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Created Tag!", colour = G.C.GREEN})
                end
            end
        end
    end
}