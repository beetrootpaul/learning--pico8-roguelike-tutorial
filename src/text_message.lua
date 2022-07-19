function new_text_message(params)
    local text_lines = params.text_lines

    local expand_length_frames = 10
    local collapse_length_frames = 10
    local frame_counter = 0
    local state = "expanding"

    local max_text_length = 0
    for text_line in all(text_lines) do
        max_text_length = max(max_text_length, u.measure_text_width(text_line))
    end

    local text_message = {}

    text_message.advance_1_frame = function()
        if state == "expanding" then
            frame_counter = frame_counter + 1
            if frame_counter >= expand_length_frames then
                state = "presenting"
            end
        elseif state == "collapsing" then
            frame_counter = frame_counter + 1
            if frame_counter >= collapse_length_frames then
                state = "hidden"
            end
        end
    end

    text_message.is_presenting = function()
        return state == "presenting"
    end

    text_message.collapse = function()
        frame_counter = 0
        state = "collapsing"
    end

    text_message.has_collapsed = function()
        return state == "hidden"
    end

    text_message.draw = function()
        if state == "hidden" then
            return
        end

        local outer_border_width = 3
        local inner_border_width = 1
        local text_margin = 5

        local inner_w = max_text_length + 2 * text_margin
        local inner_h = #text_lines * (u.text_height_px + 1) - 1 + 2 * text_margin
        if state == "expanding" then
            inner_h = inner_h * frame_counter / expand_length_frames
        elseif state == "collapsing" then
            inner_h = inner_h * (1 - frame_counter / collapse_length_frames)
        end
        local inner_x = u.screen_edge_length / 2 - inner_w / 2
        local inner_y = u.screen_edge_length / 2 - inner_h / 2

        rectfill(
            inner_x - inner_border_width - outer_border_width,
            inner_y - inner_border_width - outer_border_width,
            inner_x + inner_w - 1 + inner_border_width + outer_border_width,
            inner_y + inner_h - 1 + inner_border_width + outer_border_width,
            u.colors.black)
        rectfill(
            inner_x - inner_border_width,
            inner_y - inner_border_width,
            inner_x + inner_w - 1 + inner_border_width,
            inner_y + inner_h - 1 + inner_border_width,
            u.colors.light_grey)
        rectfill(
            inner_x,
            inner_y,
            inner_x + inner_w - 1,
            inner_y + inner_h - 1,
            u.colors.black)

        if state == "presenting" then
            for index, text_line in pairs(text_lines) do
                print(text_line,
                    inner_x + text_margin + (max_text_length - u.measure_text_width(text_line)) / 2,
                    inner_y + text_margin + (index - 1) * (u.text_height_px + 1),
                    u.colors.light_grey)
            end
        end

        if state == "presenting" then
            local button_x = inner_x + inner_w - 3
            local button_y = inner_y + inner_h - 2
            local changing_0_or_1_px = ceil(sin(time() * 2) / 2)
            u.print_with_outline("❎",
                button_x,
                button_y - changing_0_or_1_px,
                u.colors.light_grey)
        end
    end

    return text_message
end
