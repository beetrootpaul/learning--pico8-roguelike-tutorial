-- -- -- -- -- -- --
-- gameplay/level --
-- -- -- -- -- -- --

function new_level(params)
    local map_position = params.map_position

    local function to_map_xy(position)
        local map_x = map_position.x_tile + position.x_tile
        local map_y = map_position.y_tile + position.y_tile
        return map_x, map_y
    end

    local function for_each_level_position(callback)
        for x_tile = 1, u.screen_size_tiles do
            for y_tile = 1, u.screen_size_tiles do
                callback({ x_tile = x_tile, y_tile = y_tile })
            end
        end
    end

    u.reload_map_from_cart()

    local l = {}

    --

    function l.to_map_xy(position)
        return to_map_xy(position)
    end

    --

    function l.get_and_clear_initial_player_position()
        local player_position
        for_each_level_position(function(position)
            local map_x, map_y = to_map_xy(position)
            if mget(map_x, map_y) == a.sprites.player_walk_1 then
                mset(map_x, map_y, a.sprites.floor)
                player_position = position
            end
        end)
        assert(
            player_position,
            "no initial player position found on a map starting on " .. map_position.x_tile .. "," .. map_position.y_tile
        )
        return player_position
    end

    --

    function l.get_and_clear_initial_monster_positions()
        local monster_positions = {}
        for_each_level_position(function(position)
            local map_x, map_y = to_map_xy(position)
            if mget(map_x, map_y) == a.sprites.monster_slime_1 then
                mset(map_x, map_y, a.sprites.floor)
                add(monster_positions, position)
            end
        end)
        return monster_positions
    end

    --

    function l.is_walkable(position)
        local sprite = mget(to_map_xy(position))
        return fget(sprite, a.sprite_flags.walkable)
    end

    --

    function l.is_level_exit(position)
        local sprite = mget(to_map_xy(position))
        return sprite == a.sprites.level_exit
    end

    --

    function l.is_stone_tablet(position)
        local sprite = mget(to_map_xy(position))
        return sprite == a.sprites.stone_tablet
    end

    --

    function l.is_door(position)
        local sprite = mget(to_map_xy(position))
        return sprite == a.sprites.door
    end
    function l.open_door(position)
        audio.sfx(a.sounds.sfx_open_door)
        local map_x, map_y = to_map_xy(position)
        mset(map_x, map_y, a.sprites.floor)
    end

    --

    function l.is_vase(position)
        local sprite = mget(to_map_xy(position))
        return sprite == a.sprites.vase_small or sprite == a.sprites.vase_big
    end
    function l.break_vase(position)
        audio.sfx(a.sounds.sfx_break_vase)
        local map_x, map_y = to_map_xy(position)
        mset(map_x, map_y, a.sprites.floor)
    end

    --

    function l.is_closed_chest(position)
        local sprite = mget(to_map_xy(position))
        return sprite == a.sprites.chest_closed
    end
    function l.open_chest(position)
        audio.sfx(a.sounds.sfx_open_chest)
        local map_x, map_y = to_map_xy(position)
        mset(map_x, map_y, a.sprites.chest_open)
    end

    --

    function l.draw(opts)
        if opts.dim_colors then
            pal(u.colors.dark_grey, u.colors.dark_blue)
            pal(u.colors.light_grey, u.colors.dark_blue)
            pal(u.colors.yellow, u.colors.violet_grey)
        end
        map(
            map_position.x_tile,
            map_position.y_tile,
            0,
            0,
            u.screen_size_tiles,
            u.screen_size_tiles
        )
        pal()
    end

    --

    return l
end