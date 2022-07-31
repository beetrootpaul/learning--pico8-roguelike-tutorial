-- -- -- -- -- -- -- -- -- -- -- -- --
-- game_states/gs_monsters_movement --
-- -- -- -- -- -- -- -- -- -- -- -- --

function new_gs_monsters_movement(params)
    local status_area = params.status_area
    local level = params.level
    local player = params.player
    local monsters = params.monsters
    local damage_indicators = params.damage_indicators
    local buffered_button = params.buffered_button

    local phase = "preparation"

    local gs = {}

    --

    function gs.update()
        local next_gs = gs

        for button, _ in pairs(u.buttons_to_directions) do
            if btnp(button) then
                buffered_button = button
            end
        end

        if phase == "preparation" then
            monsters.walk_to_player {
                player = player,
                level = level,
                damage_indicators = damage_indicators,
            }
            phase = "execution"
        elseif phase == "execution" and not monsters.is_any_monster_moving() then
            next_gs = new_gs_player_turn {
                status_area = status_area,
                level = level,
                player = player,
                monsters = monsters,
                damage_indicators = damage_indicators,
                buffered_button = buffered_button,
            }
        end

        monsters.remove_dead()
        if player.is_dead() then
            next_gs = new_gs_level_end {
                status_area = status_area,
                level = level,
                player = player,
                monsters = monsters,
                damage_indicators = damage_indicators,
                next_level_number = nil,
            }
        end

        player.animate()
        monsters.animate()
        damage_indicators.animate()

        return next_gs
    end

    --

    function gs.draw()
        level.draw()
        player.draw()
        monsters.draw()
        damage_indicators.draw()

        status_area.draw(player.health())

        if __debug__ then
            u.print_with_outline("gs_monsters_movement", 1, 1, u.colors.red, u.colors.dark_blue)
        end
    end

    --

    return gs
end