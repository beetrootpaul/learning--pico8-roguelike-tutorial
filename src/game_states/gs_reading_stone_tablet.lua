-- -- -- -- -- -- -- -- -- -- -- -- -- --
-- game_states/gs_reading_stone_tablet --
-- -- -- -- -- -- -- -- -- -- -- -- -- --

function new_gs_reading_stone_tablet(params)
    local level = params.level
    local player = params.player
    local monsters = params.monsters
    local damage_indicators = params.damage_indicators
    local buffered_button = params.buffered_button
    local tablet_position = params.tablet_position

    local map_x, map_y = level.to_map_xy(tablet_position)
    local text_message = new_text_message {
        text_lines = a.stone_tablet_texts[map_x .. "-" .. map_y]
    }

    local gs = {}

    --

    function gs.update()
        local next_gs = gs

        if text_message.is_presenting() and btnp(u.buttons.x) then
            text_message.collapse()
        elseif text_message.has_collapsed() then
            next_gs = new_gs_monsters_movement {
                level = level,
                player = player,
                monsters = monsters,
                damage_indicators = damage_indicators,
                buffered_button = buffered_button,
            }
        end

        player.animate()
        monsters.animate()
        damage_indicators.animate()

        text_message.animate()

        return next_gs
    end

    --

    function gs.draw()
        level.draw {
            dim_colors = true,
        }
        monsters.draw {
            dim_colors = true,
        }
        player.draw {
            dim_colors = true,
        }
        damage_indicators.draw {
            dim_colors = true,
        }

        text_message.draw()

        if __debug__ then
            u.print_with_outline("gs_reading_stone_tablet", 1, 1, u.colors.blue, u.colors.dark_blue)
        end
    end

    --

    return gs
end