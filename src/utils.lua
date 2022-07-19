-- TODO: refactor to `u = new_utils()`

local buttons = {
    l = 0,
    r = 1,
    u = 2,
    d = 3,
    o = 4,
    x = 5,
}
local text_height_px = 5
local text_character_width_px = 3
local screen_edge_tiles = 16

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
    levels = {
        {
            player_start = {
                x_tile = 1, y_tile = 2,
            },
            map_position = {
                x_tile = 0, y_tile = 0,
            },
        },
        {
            player_start = {
                x_tile = 17 - screen_edge_tiles, y_tile = 14,
            },
            map_position = {
                x_tile = screen_edge_tiles, y_tile = 0,
            },
        }
    },
    measure_text_width = function(text)
        local y_to_print_outside_screen = -text_height_px
        return print(text, 0, y_to_print_outside_screen) - 1
    end,
    print_with_outline = function(text, x, y, text_color, outline_color)
        -- Docs on Control Codes: https://www.lexaloffle.com/dl/docs/pico-8_manual.html#Control_Codes
        for control_code in all(split "\-f,\-h,\|f,\|h,\+ff,\+hh,\+fh,\+hf") do
            print(control_code .. text, x, y, outline_color)
        end
        print(text, x, y, text_color)
    end,
    screen_edge_length = 128,
    screen_edge_tiles = screen_edge_tiles,
    sounds = {
        walk_step_sfx = 2,
        wall_bump_sfx = 3,
        door_open_sfx = 0,
        chest_open_sfx = 1,
    },
    sprites = {
        door = 47,
        chest = {
            closed = 45,
            open = 46,
        },
        floor = 32,
        level_exit = 15,
        player = {
            sprite_1 = 1,
            sprite_2 = 2,
            sprite_3 = 3,
            sprite_4 = 4,
        },
        stone_tablet = 42,
        vase = {
            small = 43,
            big = 44,
        },
    },
    stone_tablet_texts = {
        ["3-2"] = { "you are not", "welcome here" },
        ["8-12"] = { "still here?" },
        -- TODO: text for other stone tablets
    },
    text_character_width_px = text_character_width_px,
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