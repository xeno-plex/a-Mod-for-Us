
SMODS.Joker{ --Anxiety
    key = "anxiety",
    config = {
        extra = {
            odds = 3,
            xmult0 = 3,
            chips0 = 120,
            odds2 = 33,
            blind_size0 = 2
        }
    },
    loc_txt = {
        ['name'] = 'Anxiety',
        ['text'] = {
            [1] = '{C:green}#1# in 3 chance {}for {X:red,C:white}X3{} Mult',
            [2] = '{C:green}#1# in 3 chance {}for {C:blue}+120{} Chips',
            [3] = '{C:green}#3# in 33 chance {}to',
            [4] = 'double {C:attention}Blind Requirement{}',
            [5] = ''
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amodforu_friend"] = true, ["amodforu_cheese"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 2, card.ability.extra.odds, 'j_amodforu_anxiety')
        local new_numerator2, new_denominator2 = SMODS.get_probability_vars(card, 2, card.ability.extra.odds2, 'j_amodforu_anxiety')
        local new_numerator3, new_denominator3 = SMODS.get_probability_vars(card, 2, card.ability.extra.odds3, 'j_amodforu_anxiety')
        return {vars = {new_numerator, new_denominator, new_numerator2, new_denominator2, new_numerator3, new_denominator3}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_bc2ccb1d', 2, card.ability.extra.odds, 'j_amodforu_anxiety', false) then
                    SMODS.calculate_effect({Xmult = 3}, context.blueprint_card or card)
                end
                if SMODS.pseudorandom_probability(card, 'group_1_004b47b3', 2, card.ability.extra.odds, 'j_amodforu_anxiety', false) then
                    SMODS.calculate_effect({chips = 120}, context.blueprint_card or card)
                end
            end
        end
        if context.after and context.cardarea == G.jokers  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_e1e73453', 2, card.ability.extra.odds2, 'j_amodforu_anxiety', false) then
                    SMODS.calculate_effect({
                        func = function()
                            if G.GAME.blind.in_blind then
                                
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Climb Higher.", colour = G.C.GREEN})
                                G.GAME.blind.chips = G.GAME.blind.chips * 2
                                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                                G.HUD_blind:recalculate()
                                return true
                            end
                        end}, card)
                    end
                end
            end
        end
    }