-- -- -- -- -- -- --
-- global/assets  --
-- -- -- -- -- -- --

a = {
    colors = {
        template = u.colors.light_grey,
    },
    levels = {
        { map_position = { x_tile = 0, y_tile = 0 } },
        { map_position = { x_tile = u.screen_size_tiles, y_tile = 0 } }
    },
    sounds = {
        sfx_walk = { track = 2, priority = 0 },
        sfx_bump = { track = 3, priority = 1 },
        sfx_hit_monster = { track = 6, priority = 2 },
        sfx_hit_player = { track = 7, priority = 3 },
        sfx_break_vase = { track = 5, priority = 4 },
        sfx_open_door = { track = 0, priority = 5 },
        sfx_open_chest = { track = 1, priority = 6 },
        sfx_read_stone_tablet = { track = 4, priority = 7 },
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
        monster_slime_1 = 17,
        monster_slime_2 = 18,
        monster_slime_3 = 19,
        monster_slime_4 = 20,
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
        ["4-2"] = { "you are not", "welcome here" },
        ["8-12"] = { "still here?" },
        ["28-12"] = { "just go back" },
        ["30-3"] = { "..." },
    },
}
