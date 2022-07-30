-- -- -- -- -- -- --
-- global/assets  --
-- -- -- -- -- -- --

a = {
    colors = {
        template = u.colors.light_grey,
    },
    levels = {
        {
            player_start = { x_tile = 1, y_tile = 2 },
            map_position = { x_tile = 0, y_tile = 0 },
        },
        {
            player_start = { x_tile = 17 - u.screen_size_tiles, y_tile = 14 },
            map_position = { x_tile = u.screen_size_tiles, y_tile = 0 },
        }
    },
    sounds = {
        sfx_walk = { track = 2, priority = 0 },
        sfx_bump = { track = 3, priority = 1 },
        sfx_break_vase = { track = 5, priority = 2 },
        sfx_open_door = { track = 0, priority = 3 },
        sfx_open_chest = { track = 1, priority = 4 },
        sfx_read_stone_tablet = { track = 4, priority = 5 },
    },
    sprite_flags = {
        walkable = 0
    },
    sprites = {
        player_walk_1 = 1,
        player_walk_2 = 2,
        player_walk_3 = 3,
        player_walk_4 = 4,
        --
        floor = 32,
        stone_tablet = 42,
        door = 47,
        vase_small = 43,
        vase_big = 44,
        chest_open = 46,
        chest_closed = 45,
        level_exit = 15,
    },
    stone_tablet_texts = {
        ["3-2"] = { "you are not", "welcome here" },
        ["8-12"] = { "still here?" },
        ["28-12"] = { "just go back" },
        ["30-3"] = { "..." },
    },
}
