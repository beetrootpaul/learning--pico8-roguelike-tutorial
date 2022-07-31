-- -- -- -- -- -- -- -- -- -- -- -- --
-- game_states/game_state_gameplay  --
-- -- -- -- -- -- -- -- -- -- -- -- --

function new_game_state_gameplay(params)
    local level_number = params.level_number

    local level = new_level {
        map_position = a.levels[level_number].map_position,
    }

    local player_position = level.get_and_clear_initial_player_position()
    local player = new_player {
        position = player_position,
    }

    local monsters = new_monsters()
    local monster_positions = level.get_and_clear_initial_monster_positions()
    for monster_position in all(monster_positions) do
        monsters.add(monster_position)
    end

    local damage_indicators = new_damage_indicators()

    local text_message

    local buffered_button

    local gs = {}

    --

    function gs.update()
        local next_gs = gs

        if text_message then
            text_message.advance_1_frame()
            if text_message.is_presenting() and btnp(u.buttons.x) then
                text_message.collapse()
            end
            if text_message.has_collapsed() then
                text_message = nil
            end

        elseif player.is_moving() then
            for button, _ in pairs(u.buttons_to_directions) do
                if btnp(button) then
                    buffered_button = button
                end
            end
        else
            local direction
            if buffered_button then
                direction = u.buttons_to_directions[buffered_button]
                buffered_button = nil
            else
                for button, _ in pairs(u.buttons_to_directions) do
                    if btnp(button) then
                        direction = u.buttons_to_directions[button]
                    end
                end
            end

            local next_position = player.next_position(direction)

            local monster = monsters.get_monster_on(next_position)
            if monster then
                player.bump(direction)
                monster.receive_damage()
                damage_indicators.add_above(next_position)
            elseif level.is_walkable(next_position) then
                player.walk(direction)
            else
                player.bump(direction)
            end

            if level.is_stone_tablet(next_position) then
                audio.sfx(a.sounds.sfx_read_stone_tablet)
                local map_x, map_y = level.to_map_xy(next_position)
                if __debug__ then
                    printh("stone tablet map xy = " .. map_x .. "," .. map_y)
                end
                text_message = new_text_message {
                    text_lines = a.stone_tablet_texts[map_x .. "-" .. map_y]
                }
            elseif level.is_door(next_position) then
                level.open_door(next_position)
            elseif level.is_vase(next_position) then
                level.break_vase(next_position)
            elseif level.is_closed_chest(next_position) then
                level.open_chest(next_position)
            end

            if level.is_level_exit(player.position()) then
                local next_level_number = u.next_table_index(level_number, #a.levels)
                next_gs = new_game_state_gameplay {
                    level_number = next_level_number,
                }
            end

        end

        player.update()

        if not monsters.is_any_monster_moving() then
            monsters.walk_to_player {
                player = player,
                level = level,
            }
        end

        monsters.update()

        damage_indicators.advance_1_frame()

        return next_gs
    end

    --

    function gs.draw()
        level.draw {
            dim_colors = text_message,
        }
        monsters.draw {
            dim_colors = text_message,
        }
        player.draw {
            dim_colors = text_message,
        }
        damage_indicators.draw {
            dim_colors = text_message,
        }

        if text_message then
            text_message.draw()
        end
    end

    --

    return gs
end