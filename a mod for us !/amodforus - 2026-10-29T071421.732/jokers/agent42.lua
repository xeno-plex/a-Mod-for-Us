
SMODS.Joker{ --_agent42
    key = "agent42",
    config = {
        extra = {
            xmult0 = 0.75,
            xmult = 3,
            scale0 = 0.2,
            rotation0 = 0.2
        }
    },
    loc_txt = {
        ['name'] = '_agent42',
        ['text'] = {
            [1] = '{X:red,C:white}X0.75{} Mult',
            [2] = 'in {C:attention}Small {}and {C:attention}Big Blind{}',
            [3] = '{X:red,C:white}X3{} Mult',
            [4] = 'during the {C:attention}Boss Blind{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
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
        if context.cardarea == G.jokers and context.joker_main  then
            if not (G.GAME.blind.boss) then
                return {
                    Xmult = 0.75
                }
            elseif G.GAME.blind.boss then
                return {
                    Xmult = 3
                }
            end
        end
        if context.setting_blind  then
            if G.GAME.blind.boss then
                local target_card = context.other_card
                local function juice_card_until_(card, eval_func, first, delay) -- balatro function doesn't allow for custom scale and rotation
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',delay = delay or 0.1, blocking = false, blockable = false, timer = 'REAL',
                    func = (function() if eval_func(card) then if not first or first then card:juice_up(0.2, 0.2) end;juice_card_until_(card, eval_func, nil, 0.8) end return true end)
                    }))
                end
                return {
                    message = "*downs energy drink*",
                    extra = {
                        func = function()
                        local eval = function() return not G.RESET_JIGGLES end
                            juice_card_until_(card, eval, true)
                            return true
                        end,
                        colour = G.C.WHITE
                    }
                }
            end
        end
    end
}