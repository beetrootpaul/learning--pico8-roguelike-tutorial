-- -- -- -- -- -- -- -- -- -- --
-- game_states/gs_game_over   --
-- -- -- -- -- -- -- -- -- -- --

function new_gs_game_over()
    local gs = {}

    --

    function gs.update()
        if btnp(u.buttons.x) then
            return new_gs_level_start {
                level_number = 1,
            }
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

        if __debug__ then
            u.print_with_outline("gs_game_over", 1, 1, u.colors.purple, u.colors.dark_blue)
        end
    end

    --

    return gs
end