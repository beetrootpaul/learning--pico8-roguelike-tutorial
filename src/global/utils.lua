-- -- -- -- -- -- --
-- global/utils   --
-- -- -- -- -- -- --

u = {
    buttons = {
        -- left, right, up, down
        l = 0,
        r = 1,
        u = 2,
        d = 3,
        -- button O (Z), button X
        o = 4,
        x = 5,
    },

    colors = {
        black = 0,
        dark_blue = 1,
        purple = 2,
        dark_green = 3,
        brown = 4,
        dark_grey = 5,
        light_grey = 6,
        white = 7,
        red = 8,
        orange = 9,
        yellow = 10,
        lime = 11,
        blue = 12,
        violet_grey = 13,
        pink = 14,
        salmon = 15,
    },

    map_space_w = 128,
    map_space_h = 64,

    screen_size = 128,
    screen_size_tiles = 16,

    text_height = 5,
    text_line_gap = 1,

    tile_size = 8,
}

u.buttons_to_directions = {
    [u.buttons.l] = { x = -1, y = 0 },
    [u.buttons.r] = { x = 1, y = 0 },
    [u.buttons.u] = { x = 0, y = -1 },
    [u.buttons.d] = { x = 0, y = 1 },
}

u.colors_to_darker_ones = {
    [u.colors.black] = u.colors.black,
    [u.colors.dark_blue] = u.colors.black,
    [u.colors.purple] = u.colors.dark_blue,
    [u.colors.dark_green] = u.colors.dark_blue,
    [u.colors.brown] = u.colors.purple,
    [u.colors.dark_grey] = u.colors.dark_blue,
    [u.colors.light_grey] = u.colors.violet_grey,
    [u.colors.white] = u.colors.light_grey,
    [u.colors.red] = u.colors.brown,
    [u.colors.orange] = u.colors.brown,
    [u.colors.yellow] = u.colors.orange,
    [u.colors.lime] = u.colors.dark_green,
    [u.colors.blue] = u.colors.violet_grey,
    [u.colors.violet_grey] = u.colors.dark_blue,
    [u.colors.pink] = u.colors.violet_grey,
    [u.colors.salmon] = u.colors.pink,
}

function u.boolean_changing_every_nth_second(n)
    return ceil(sin(time() * 0.5 / n) / 2) == 1
end

function u.darken_display_colors(params)
    pal()
    for _, color in pairs(u.colors) do
        local new_color = color
        for _ = 1, params.steps do
            new_color = u.colors_to_darker_ones[new_color]
        end
        pal(color, new_color, 1)
    end
end

function u.measure_text_width(text)
    local y_to_print_outside_screen = -u.text_height
    return print(text, 0, y_to_print_outside_screen) - 1
end

function u.next_table_index(current_index, table_length)
    local offset_for_1_indexed_table = 1
    return offset_for_1_indexed_table + (current_index + 1 - offset_for_1_indexed_table) % table_length
end

function u.print_with_outline(text, x, y, text_color, outline_color)
    -- Docs on Control Codes: https://www.lexaloffle.com/dl/docs/pico-8_manual.html#Control_Codes
    for control_code in all(split "\-f,\-h,\|f,\|h,\+ff,\+hh,\+fh,\+hf") do
        print(control_code .. text, x, y, outline_color)
    end
    print(text, x, y, text_color)
end

function u.reload_map_from_cart()
    reload(0x2000, 0x2000, 0x1000)
end

function u.set_btnp_delay(params)
    if params.initial then
        poke(0x5f5c, params.initial)
    end
    if params.repeating then
        poke(0x5f5d, 4)
    end
end

function u.trim(text)
    local result = text
    while sub(result, 1, 1) == ' ' do
        result = sub(result, 2)
    end
    while sub(result, #result, #result) == ' ' do
        result = sub(result, 0, #result - 1)
    end
    return result
end