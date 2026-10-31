
SMODS.Back {
    key = 'eeveelution_deck',
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            booster_slots0 = 1
        },
        vouchers = { "v_hone" },
    },
    loc_txt = {
        name = 'Eeveelution Deck',
        text = {
            [1] = '{C:attention}+1{} Booster Pack slot',
            [2] = 'Begin run with {C:attention}Hone {}voucher'
        },
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    atlas = 'CustomDecks',
    apply = function(self, back)
        return {
            
            G.E_MANAGER:add_event(Event({
                func = function()
                    
                    
                    SMODS.change_booster_limit(1)
                    return true
                end
            }))
        }
    end
}