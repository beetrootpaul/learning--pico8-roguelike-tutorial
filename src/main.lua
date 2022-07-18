local level = 1

local player = new_player {
    x_tile = u.levels[level].player_start.x_tile,
    y_tile = u.levels[level].player_start.y_tile,
}

function _update60()
    d:update()

    player.animated_walk.advance_1_frame()

    if player.movement1 then
        for button, _ in pairs(u.buttons_to_directions) do
            if btnp(button) then
                player.buffered_button = button
            end
        end
        if player.movement1.has_finished then
            player.movement1 = nil
        else
            player.movement1.advance_1_frame()
        end
    elseif player.movement2 then
        for button, _ in pairs(u.buttons_to_directions) do
            if btnp(button) then
                player.buffered_button = button
            end
        end
        if player.movement2.has_finished then
            player.movement2 = nil
        else
            player.movement2.advance_1_frame()
        end
    else
        local button_to_handle = player.buffered_button
        if button_to_handle then
            player.buffered_button = nil
        else
            for button, _ in pairs(u.buttons_to_directions) do
                if btnp(button) then
                    button_to_handle = button
                end
            end
        end
        if button_to_handle then
            local direction = u.buttons_to_directions[button_to_handle]
            local next_x, next_y = player.x_tile + direction.x, player.y_tile + direction.y
            local tile = mget(u.levels[level].map_position.x_tile + next_x, u.levels[level].map_position.y_tile + next_y)
            if tile == u.sprites.level_exit then
                if level < #u.levels then
                    level = level + 1
                    player = new_player {
                        x_tile = u.levels[level].player_start.x_tile,
                        y_tile = u.levels[level].player_start.y_tile,
                    }
                else
                    extcmd("reset")
                end
                return
            end
            if fget(tile, u.flags.non_walkable) then
                player.movement1 = new_movement_animation {
                    start_x = player.x_tile * u.tile_edge_length,
                    start_y = player.y_tile * u.tile_edge_length,
                    end_x = player.x_tile * u.tile_edge_length + (next_x * u.tile_edge_length - player.x_tile * u.tile_edge_length) / 4,
                    end_y = player.y_tile * u.tile_edge_length + (next_y * u.tile_edge_length - player.y_tile * u.tile_edge_length) / 4,
                }
                player.movement2 = new_movement_animation {
                    start_x = player.x_tile * u.tile_edge_length + (next_x * u.tile_edge_length - player.x_tile * u.tile_edge_length) / 4,
                    start_y = player.y_tile * u.tile_edge_length + (next_y * u.tile_edge_length - player.y_tile * u.tile_edge_length) / 4,
                    end_x = player.x_tile * u.tile_edge_length,
                    end_y = player.y_tile * u.tile_edge_length,
                }
                if direction.x > 0 then
                    player.facing_right = true
                elseif direction.x < 0 then
                    player.facing_right = false
                end
                if tile == u.sprites.door then
                    sfx(u.sounds.door_open_sfx)
                    mset(u.levels[level].map_position.x_tile + next_x, u.levels[level].map_position.y_tile + next_y, u.sprites.floor)
                elseif tile == u.sprites.chest.closed then
                    sfx(u.sounds.chest_open_sfx)
                    mset(u.levels[level].map_position.x_tile + next_x, u.levels[level].map_position.y_tile + next_y, u.sprites.chest.open)
                elseif tile == u.sprites.vase.small or tile == u.sprites.vase.big then
                    -- TODO: SFX
                    mset(u.levels[level].map_position.x_tile + next_x, u.levels[level].map_position.y_tile + next_y, u.sprites.floor)
                else
                    sfx(u.sounds.wall_bump_sfx)
                end
            else
                player.movement1 = new_movement_animation {
                    start_x = player.x_tile * u.tile_edge_length,
                    start_y = player.y_tile * u.tile_edge_length,
                    end_x = next_x * u.tile_edge_length,
                    end_y = next_y * u.tile_edge_length,
                }
                player.x_tile = next_x
                player.y_tile = next_y
                if direction.x > 0 then
                    player.facing_right = true
                elseif direction.x < 0 then
                    player.facing_right = false
                end
                sfx(u.sounds.walk_step_sfx)
            end
        end
    end
end

function _draw()
    cls()

    map(u.levels[level].map_position.x_tile, u.levels[level].map_position.y_tile,
        0, 0,
        u.screen_edge_tiles, u.screen_edge_tiles)

    palt(u.colors.black, false)
    pal(u.colors.light_grey, u.colors.yellow)
    if player.movement1 then
        spr(player.animated_walk.current_sprite(),
            player.movement1.x,
            player.movement1.y,
            1, 1,
            not player.facing_right)
    elseif player.movement2 then
        spr(player.animated_walk.current_sprite(),
            player.movement2.x,
            player.movement2.y,
            1, 1,
            not player.facing_right)
    else
        spr(player.animated_walk.current_sprite(),
            player.x_tile * u.tile_edge_length,
            player.y_tile * u.tile_edge_length,
            1, 1,
            not player.facing_right)
    end
    pal()

    d:draw()
end

-- TODO: non-walkable: stone tablet
-- TODO: can-interact-with flag: stone tablet
-- TODO: interaction: stone tablet -> (nothing yet)

-- TODO: SFX for chest open, but no space in inventory

-- TODO: function to draw a window with border with text inside, clipped to not overflow
-- TODO: show text window on stone tablet bump
-- TODO: window size fits text width; text as an array of lines
-- TODO: window appears and disappear in animated way
-- TODO: window disappear on X press
-- TODO: X animated (`SIN(TIME())` might be helpful)
-- TODO: multiple stone tablets with their texts (maybe use last sprite flags as binary number of text?)

-- TODO: move continued movement smoother
