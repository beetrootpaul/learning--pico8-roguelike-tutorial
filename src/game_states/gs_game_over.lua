-- -- -- -- -- -- -- -- -- -- --
-- game_states/gs_game_over   --
-- -- -- -- -- -- -- -- -- -- --

function new_gs_game_over()
    local state = "fading_in"

    local fade_in_ttl_max = 8
    local fade_in_ttl = fade_in_ttl_max
    local fade_out_ttl_max = 8
    local fade_out_ttl = fade_out_ttl_max

    local gs = {}

    --

    function gs.update()
        if state == "fading_in" then
            if fade_in_ttl > 0 then
                fade_in_ttl = max(0, fade_in_ttl - 1)
            else
                state = "awaiting_button"
            end
        elseif state == "awaiting_button" then
            if btnp(u.buttons.x) then
                state = "fading_out"
            end
        elseif state == "fading_out" then
            if fade_out_ttl > 0 then
                fade_out_ttl = max(0, fade_out_ttl - 1)
            else
                return new_gs_level_start {
                    player_health = new_health {
                        max = 5,
                    },
                    level_number = 1,
                }
            end
        end

        return gs
    end

    --

    function gs.draw()
        local text_1 = "death"
        local text_1_w = u.measure_text_width(text_1)
        local text_2 = "press ❎ to start again"
        local text_2_w = u.measure_text_width(text_2)

        u.print_with_outline(
            text_1,
            u.screen_size / 2 - text_1_w / 2,
            u.screen_size / 2 - u.text_height - 5,
            u.colors.light_grey,
            u.colors.purple
        )
        print(
            text_2,
            u.screen_size / 2 - text_2_w / 2,
            u.screen_size / 2 + 5,
            u.colors.light_grey
        )

        if state == "fading_in" then
            u.darken_display_colors {
                steps = ceil(4 * fade_in_ttl / fade_in_ttl_max)
            }
        elseif state == "fading_out" then
            u.darken_display_colors {
                steps = ceil(4 * (1 - fade_out_ttl / fade_out_ttl_max))
            }
        end

        if __debug__ then
            u.print_with_outline("gs_game_over", 1, 1, u.colors.purple, u.colors.dark_blue)
        end
    end

    --

    return gs
end