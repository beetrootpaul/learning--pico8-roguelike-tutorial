local buttons = {
    l = 0,
    r = 1,
    u = 2,
    d = 3,
    o = 4,
    x = 5,
}
local text_height_px = 5

local utils = {
    buttons = buttons,
    buttons_to_directions = {
        [buttons.l] = { x = -1, y = 0 },
        [buttons.r] = { x = 1, y = 0 },
        [buttons.u] = { x = 0, y = -1 },
        [buttons.d] = { x = 0, y = 1 },
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
    flags = {
        non_walkable = 0,
    },
    measure_text_width = function(text)
        local y_to_print_outside_screen = -text_height_px
        return print(text, 0, y_to_print_outside_screen)
    end,
    screen_edge_length = 128,
    screen_edge_tiles = 16,
    sprites = {
        player = {
            sprite_1 = 1,
            sprite_2 = 2,
            sprite_3 = 3,
            sprite_4 = 4,
        },
    },
    text_height_px = text_height_px,
    tile_edge_length = 8,
    trim = function(text)
        local result = text
        while sub(result, 1, 1) == ' ' do
            result = sub(result, 2)
        end
        while sub(result, #result, #result) == ' ' do
            result = sub(result, 0, #result - 1)
        end
        return result
    end
}

u = utils