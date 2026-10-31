
SMODS.Joker{ --kyuri/aisu
    key = "kyuriaisu",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'kyuri/aisu',
        ['text'] = {
            [1] = 'All played {C:attention}unenhanced {}cards',
            [2] = 'that are {C:attention}#1# {}suit become',
            [3] = '{C:attention}Wild{} cards when scored',
            [4] = '{C:inactive}(Suit changes every round){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amodforu_friend"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {localize((G.GAME.current_round.suit_card or {}).suit or 'Spades', 'suits_singular')}, colours = {G.C.SUITS[(G.GAME.current_round.suit_card or {}).suit or 'Spades']}}
    end,
    
    set_ability = function(self, card, initial)
        G.GAME.current_round.suit_card = { suit = 'Spades' }
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if G.playing_cards then
                local valid_suit_cards = {}
                for _, v in ipairs(G.playing_cards) do
                    if not SMODS.has_no_suit(v) then
                        valid_suit_cards[#valid_suit_cards + 1] = v
                    end
                end
                if valid_suit_cards[1] then
                    local suit_card = pseudorandom_element(valid_suit_cards, pseudoseed('suit' .. G.GAME.round_resets.ante))
                    G.GAME.current_round.suit_card.suit = suit_card.base.suit
                end
            end
        end
        if context.before and context.cardarea == G.jokers  then
                        local faces = {}
                        for k, v in ipairs(context.scoring_hand) do
                            if v:is_suit(G.GAME.current_round.suit_card.suit) and v.config.center == G.P_CENTERS.c_base  then 
                                faces[#faces+1] = v
                                v:set_ability(G.P_CENTERS.m_wild, nil, true)
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        v:juice_up()
                                        return true
                                    end
                                })) 
                            end
                        end
                        if #faces > 0 then 
                            return {
                                message = "mwah!"
                            }
                        end
                    end
                end
}