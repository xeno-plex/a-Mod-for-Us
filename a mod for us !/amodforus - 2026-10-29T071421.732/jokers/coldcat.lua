
SMODS.Joker{ --cold cat
    key = "coldcat",
    config = {
        extra = {
            enhancement = 'm_mult',
            textenha = 'Mult Card',
            chips = 0
        }
    },
    loc_txt = {
        ['name'] = 'cold cat',
        ['text'] = {
            [1] = 'This Joker gains {C:chips}+15{}',
            [2] = 'Chips when each played',
            [3] = '{C:attention}#2# {}is scored',
            [4] = '{C:inactive}(Currently {C:blue}+#3# {}{C:inactive}Chips){}',
            [5] = '{C:inactive}(Enhancement changes',
            [6] = '{C:inactive}every round){}{}{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amodforu_friend"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.enhancement, card.ability.extra.textenha, card.ability.extra.chips}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
            local possible_enhancements = {}
            for _, v in pairs(G.P_CENTER_POOLS.Enhanced) do
                possible_enhancements[#possible_enhancements + 1] = v.key
            end
            local random_enhancement_result = pseudorandom_element(possible_enhancements, 'random enhancement')
            card.ability.extra.enhancement = random_enhancement_result
        end
        if context.individual and context.cardarea == G.play  then
            if SMODS.get_enhancements(context.other_card)[card.ability.extra.enhancement] == true then
                card.ability.extra.chips = (card.ability.extra.chips) + 15
                return {
                    message = "Upgrade!"
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = card.ability.extra.chips,
                message = "icy!"
            }
        end
        if context.starting_shop  then
            if card.ability.extra.enhancement == "m_mult" then
                card.ability.extra.textenha = 'Mult Card'
            elseif card.ability.extra.enhancement == "m_bonus" then
                card.ability.extra.textenha = 'Bonus Card'
            elseif (not (card.ability.extra.enhancement == "m_mult") and not (card.ability.extra.enhancement == "m_bonus")) then
                local all_key_lists = {}
                for _, pool in pairs(G.P_CENTER_POOLS) do
                    for _, item in pairs(pool) do
                        table.insert(all_key_lists, item)
                    end      
                end
                for _, current_card in pairs(all_key_lists) do
                    if current_card.key == card.ability.extra.enhancement then
                        if current_card.set == "Seal" then
                            card.ability.extra.textenha = current_card.key
                        else 
                            card.ability.extra.textenha = current_card.name
                        end
                        break
                    end
                end
            end
        end
    end
}