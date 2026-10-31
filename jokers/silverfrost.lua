
SMODS.Joker{ --SilverFrost
    key = "silverfrost",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'SilverFrost',
        ['text'] = {
            [1] = 'Creates {C:attention}2{} random {C:spectral}Negative',
            [2] = '{}{C:spectral}Spectral{} cards when a',
            [3] = '{C:attention}Blind{} is skipped',
            [4] = '{C:inactive}stop changing ur pfp{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
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
    pools = { ["amodforu_friend"] = true },
    
    calculate = function(self, card, context)
        if context.skip_blind  then
            return {
                message = "meow!",
                extra = {
                    func = function()
                        
                        for i = 1, 2 do
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.4,
                                func = function()
                                    if G.consumeables.config.card_limit > #G.consumeables.cards + G.GAME.consumeable_buffer then
                                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                                    end
                                    
                                    play_sound('timpani')
                                    SMODS.add_card({ set = 'Spectral', edition = 'e_negative', })                            
                                    card:juice_up(0.3, 0.5)
                                    return true
                                end
                            }))
                        end
                        delay(0.6)
                        
                        if created_consumable then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                        end
                        return true
                    end,
                    colour = G.C.SECONDARY_SET.Spectral
                }
            }
        end
    end
}