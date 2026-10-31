
SMODS.Back {
    key = 'bootleg_knox_deck',
    pos = { x = 1, y = 0 },
    config = {
        extra = {
            ante_value0 = 0
        },
    },
    loc_txt = {
        name = 'bootleg knox deck',
        text = {
            [1] = '{X:red,C:white}UNLICENSED{} and {X:red,C:white}UNOFFICIAL{}',
            [2] = 'Start at {C:attention}Ante 0{}',
            [3] = 'Rerolls cost {C:money}$2{} more'
        },
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    atlas = 'CustomDecks',
    apply = function(self, back)
        local mod = 0 - G.GAME.round_resets.ante
        G.E_MANAGER:add_event(Event({
            func = function()
                ease_ante(mod)
                G.GAME.round_resets.blind_ante = 0
                return true
            end,
        }))
        return {
            
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + 2
                    G.GAME.current_round.reroll_cost = math.max(0,
                    G.GAME.current_round.reroll_cost + 2)
                    return true
                end
            }))
            
        }
    end
}