function new_text_message(params)
    local text_lines = params.text_lines

    local text_message = {}

    text_message.draw = function()
        local max_text_length = 0
        for text_line in all(text_lines) do
            max_text_length = max(max_text_length, u.measure_text_width(text_line))
        end

        local inner_w = max_text_length
        local inner_h = #text_lines * (u.text_height_px + 1) - 1
        local inner_x = u.screen_edge_length / 2 - inner_w / 2
        local inner_y = u.screen_edge_length / 2 - inner_h / 2

        local outer_border_width = 3
        local inner_border_width = 1
        local text_margin = 6

        rectfill(
            inner_x - text_margin - inner_border_width - outer_border_width,
            inner_y - text_margin - inner_border_width - outer_border_width,
            inner_x + inner_w - 1 + text_margin + inner_border_width + outer_border_width,
            inner_y + inner_h - 1 + text_margin + inner_border_width + outer_border_width,
            u.colors.black)
        rectfill(
            inner_x - text_margin - inner_border_width,
            inner_y - text_margin - inner_border_width,
            inner_x + inner_w - 1 + text_margin + inner_border_width,
            inner_y + inner_h - 1 + text_margin + inner_border_width,
            u.colors.light_grey)
        rectfill(
            inner_x - text_margin,
            inner_y - text_margin,
            inner_x + inner_w - 1 + text_margin,
            inner_y + inner_h - 1 + text_margin,
            u.colors.black)

        for index, text_line in pairs(text_lines) do
            print(text_line,
                inner_x + (max_text_length - u.measure_text_width(text_line)) / 2,
                inner_y + (index - 1) * (u.text_height_px + 1),
                u.colors.light_grey)
        end

        local button_x = inner_x + inner_w + text_margin - 3
        local button_y = inner_y + inner_h + text_margin - 2
        local changing_0_or_1_px = ceil(sin(time()) / 2)
        u.print_with_outline("❎",
            button_x,
            button_y - changing_0_or_1_px,
            u.colors.light_grey)
    end

    return text_message
end
