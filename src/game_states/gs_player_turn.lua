-- -- -- -- -- -- -- -- -- -- --
-- game_states/gs_player_turn --
-- -- -- -- -- -- -- -- -- -- --

function new_gs_player_turn(params)
    local level = params.level
    local player = params.player
    local monsters = params.monsters
    local damage_indicators = params.damage_indicators
    local buffered_button = params.buffered_button

    local gs = {}

    --

    function gs.update()
        local next_gs = gs

        local direction
        if buffered_button then
            direction = u.buttons_to_directions[buffered_button]
        else
            for button, _ in pairs(u.buttons_to_directions) do
                if btnp(button) then
                    direction = u.buttons_to_directions[button]
                end
            end
        end

        if direction then
            next_gs = new_gs_player_movement({
                level = level,
                player = player,
                monsters = monsters,
                damage_indicators = damage_indicators,
                player_direction = direction,
            })
        end

        monsters.remove_dead()

        player.animate()
        monsters.animate()
        damage_indicators.animate()

        return next_gs
    end

    --

    function gs.draw()
        level.draw()
        monsters.draw()
        player.draw()
        damage_indicators.draw()

        if __debug__ then
            u.print_with_outline("gs_player_turn", 1, 1, u.colors.dark_green, u.colors.dark_blue)
        end
    end

    --

    return gs
end