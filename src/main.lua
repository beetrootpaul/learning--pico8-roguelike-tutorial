local level = 1

local player = new_player {
    x_tile = u.levels[level].player_start.x_tile,
    y_tile = u.levels[level].player_start.y_tile,
}

local text_message = nil

function _init()
    for location, _ in pairs(u.stone_tablet_texts) do
        local tile_x = split(location, "-")[1]
        local tile_y = split(location, "-")[2]
        local sprite = mget(tile_x, tile_y)
        assert(sprite == u.sprites.stone_tablet,
            "no stone tablet found at tile (" .. tile_x .. "," .. tile_y .. "). found sprite " .. sprite .. " instead")
    end
end

-- TODO: refactor this function
function _update60()
    d:update()

    if text_message then
        text_message.advance_1_frame()
    end

    player.animated_walk.advance_1_frame()

    -- TODO: movement seems not so smooth when button is pressed for a long time, like if there was an extra pause frame everytime a tile is reached
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
    elseif text_message then
        if text_message.is_presenting() and btnp(u.buttons.x) then
            text_message.collapse()
        end
        if text_message.has_collapsed() then
            text_message = nil
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
            local sprite = mget(u.levels[level].map_position.x_tile + next_x, u.levels[level].map_position.y_tile + next_y)
            if sprite == u.sprites.level_exit then
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
            if fget(sprite, u.flags.non_walkable) then
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
                if sprite == u.sprites.door then
                    sfx(u.sounds.door_open_sfx)
                    mset(u.levels[level].map_position.x_tile + next_x, u.levels[level].map_position.y_tile + next_y, u.sprites.floor)
                elseif sprite == u.sprites.chest.closed then
                    -- TODO: SFX for chest open, but no space in inventory
                    sfx(u.sounds.chest_open_sfx)
                    mset(u.levels[level].map_position.x_tile + next_x, u.levels[level].map_position.y_tile + next_y, u.sprites.chest.open)
                elseif sprite == u.sprites.vase.small or sprite == u.sprites.vase.big then
                    -- TODO: SFX
                    mset(u.levels[level].map_position.x_tile + next_x, u.levels[level].map_position.y_tile + next_y, u.sprites.floor)
                elseif sprite == u.sprites.stone_tablet then
                    -- TODO: SFX
                    local text_lines = u.stone_tablet_texts[(u.levels[level].map_position.x_tile + next_x) .. "-" .. (u.levels[level].map_position.y_tile + next_y)]
                    text_message = new_text_message({
                        text_lines = text_lines or { "lorem ipsum... ?" }
                    })
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

    if text_message then
        text_message.draw()
    end

    d:draw()
end
