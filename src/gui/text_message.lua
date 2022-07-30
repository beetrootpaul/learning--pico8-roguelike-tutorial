-- -- -- -- -- -- -- --
-- gui/text_message  --
-- -- -- -- -- -- -- --

function new_text_message(params)
    local text_lines = params.text_lines

    local expand_length_frames = 6
    local collapse_length_frames = 6
    local frame_counter = 0
    local state = "expanding"

    local max_text_length = 0
    for text_line in all(text_lines) do
        max_text_length = max(max_text_length, u.measure_text_width(text_line))
    end

    local tm = {}

    --

    function tm.advance_1_frame()
        if state == "expanding" then
            if frame_counter < expand_length_frames then
                frame_counter = frame_counter + 1
            else
                state = "presenting"
            end
        elseif state == "collapsing" then
            if frame_counter < collapse_length_frames then
                frame_counter = frame_counter + 1
            else
                state = "hidden"
            end
        end
    end

    --

    function tm.is_presenting()
        return state == "presenting"
    end

    --

    function tm.collapse()
        frame_counter = 0
        state = "collapsing"
    end

    --

    function tm.has_collapsed()
        return state == "hidden"
    end

    --

    function tm.draw()
        if state == "hidden" then
            return
        end

        local outer_border_width = 3
        local inner_border_width = 1
        local text_margin = 5

        local inner_w = max_text_length + 2 * text_margin
        local inner_h = #text_lines * (u.text_height + u.text_line_gap) - u.text_line_gap + 2 * text_margin
        if state == "expanding" then
            inner_h = inner_h * frame_counter / expand_length_frames
        elseif state == "collapsing" then
            inner_h = inner_h * (1 - frame_counter / collapse_length_frames)
        end
        local inner_x = u.screen_size / 2 - inner_w / 2
        local inner_y = u.screen_size / 2 - inner_h / 2

        rectfill(
            inner_x - inner_border_width - outer_border_width,
            inner_y - inner_border_width - outer_border_width,
            inner_x + inner_w - 1 + inner_border_width + outer_border_width,
            inner_y + inner_h - 1 + inner_border_width + outer_border_width,
            u.colors.black
        )
        rectfill(
            inner_x - inner_border_width,
            inner_y - inner_border_width,
            inner_x + inner_w - 1 + inner_border_width,
            inner_y + inner_h - 1 + inner_border_width,
            u.colors.light_grey
        )
        rectfill(
            inner_x,
            inner_y,
            inner_x + inner_w - 1,
            inner_y + inner_h - 1,
            u.colors.black
        )

        if state == "presenting" then
            for index, text_line in pairs(text_lines) do
                print(
                    text_line,
                    inner_x + text_margin + (max_text_length - u.measure_text_width(text_line)) / 2,
                    inner_y + text_margin + (index - 1) * (u.text_height + u.text_line_gap),
                    u.colors.light_grey
                )
            end
        end

        if state == "presenting" then
            local button_x = inner_x + inner_w - 3
            local button_y = inner_y + inner_h - 2
            local time_dependent_boolean = u.boolean_changing_every_nth_second(0.25)
            u.print_with_outline(
                "❎",
                button_x,
                button_y - (time_dependent_boolean and 1 or 0),
                u.colors.light_grey
            )
        end
    end

    --

    return tm
end