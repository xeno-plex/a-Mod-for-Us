
SMODS.Joker{ --Notorious
    key = "notorious",
    config = {
        extra = {
            xmult = 1,
            xmult0 = 3
        }
    },
    loc_txt = {
        ['name'] = 'Notorious',
        ['text'] = {
            [1] = '{X:red,C:white}X3{} Mult',
            [2] = '{C:attention}Flip and shuffle {}all Jokers',
            [3] = 'when {C:attention}Blind{} is selected and',
            [4] = 'draw first hand {C:attention}face down{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amodforu_friend"] = true, ["amodforu_cheese"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmult}}
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind  then
            if #G.jokers.cards > 0 then
                for _, joker in ipairs(G.jokers.cards) do
                    joker:flip()
                end
            end
            if #G.jokers.cards > 1 then
                G.jokers:unhighlight_all()
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.jokers:shuffle('aajk')
                                play_sound('cardSlide1', 0.85)
                                return true
                            end,
                        }))
                        delay(0.15)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.jokers:shuffle('aajk')
                                play_sound('cardSlide1', 1.15)
                                return true
                            end
                        }))
                        delay(0.15)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.jokers:shuffle('aajk')
                                play_sound('cardSlide1', 1)
                                return true
                            end
                        }))
                        delay(0.5)
                        return true
                    end
                }))
            end
            return {
                message = "Flip!",
                extra = {
                    message = "Shuffle!",
                    colour = G.C.ORANGE
                }
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = 3
            }
        end
        if context.first_hand_drawn  then
            return {
                message = "*vagueposts*"
            }
        end
        if not context.blueprint then
            if context.stay_flipped then
                if G.GAME.current_round.hands_played == 0 and G.GAME.current_round.discards_used == 0 then
                    return { stay_flipped = true }
                end 
                -- else return { stay_flipped = false }
            end
        end
        if context.cardarea == G.jokers and context.press_play then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    for k, v in ipairs(G.play.cards) do
                        if v.facing == 'back' then
                            v:flip()
                        end
                    end
                    return true
                end)
            }))
        end
    end
}

