-- -- -- -- -- -- -- -- -- -- -- -- --
-- game_states/gs_player_movement   --
-- -- -- -- -- -- -- -- -- -- -- -- --

function new_gs_player_movement(params)
    local player_health = params.player_health
    local level = params.level
    local player = params.player
    local monsters = params.monsters
    local damage_indicators = params.damage_indicators
    local player_direction = params.player_direction

    local health_display = new_health_display {
        health = player_health,
    }

    local buffered_button
    local stone_tablet_to_read_position

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
            local next_position = player.next_position(player_direction)

            local monster = monsters.get_monster_on(next_position)
            if monster then
                player.bump(player_direction)
                if not monster.is_defeated() then
                    monster.receive_damage()
                    damage_indicators.add_above(next_position)
                end
            elseif level.is_walkable(next_position) then
                player.walk_to(next_position)
            else
                player.bump(player_direction)
            end
            --
            if level.is_stone_tablet(next_position) then
                audio.sfx(a.sounds.sfx_read_stone_tablet)
                stone_tablet_to_read_position = next_position
            elseif level.is_door(next_position) then
                level.open_door(next_position)
            elseif level.is_vase(next_position) then
                level.break_vase(next_position)
            elseif level.is_closed_chest(next_position) then
                level.open_chest(next_position)
            end

            if level.is_level_exit(player.position()) then
                next_gs = new_gs_level_end {
                    player_health = player_health,
                    level = level,
                    player = player,
                    monsters = monsters,
                    damage_indicators = damage_indicators,
                    next_level_number = level.next_level_number(),
                }
            end

            phase = "execution"
        elseif phase == "execution" and not player.is_moving() then
            if stone_tablet_to_read_position then
                next_gs = new_gs_reading_stone_tablet {
                    player_health = player_health,
                    level = level,
                    player = player,
                    monsters = monsters,
                    damage_indicators = damage_indicators,
                    buffered_button = buffered_button,
                    tablet_position = stone_tablet_to_read_position,
                }
            else
                next_gs = new_gs_monsters_movement {
                    player_health = player_health,
                    level = level,
                    player = player,
                    monsters = monsters,
                    damage_indicators = damage_indicators,
                    buffered_button = buffered_button,
                }
            end
        end

        monsters.remove_dead()
        if player.is_dead() then
            next_gs = new_gs_level_end {
                player_health = player_health,
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
        monsters.draw()
        player.draw()
        damage_indicators.draw()

        health_display.draw()

        if __debug__ then
            u.print_with_outline("gs_player_movement", 1, 1, u.colors.lime, u.colors.dark_blue)
        end
    end

    --

    return gs
end