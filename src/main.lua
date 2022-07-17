function new_movement(params)
    local start_x, start_y = params.start_x, params.start_y
    local end_x, end_y = params.end_x, params.end_y

    local movement = {
        x = start_x,
        y = start_y,
        has_finished = false
    }

    movement.advance_1_frame = function()
        if movement.x == end_x and movement.y == end_y then
            movement.has_finished = true
        end
        if movement.x ~= end_x then
            movement.x = movement.x + 1 * sgn(end_x - movement.x)
        end
        if movement.y ~= end_y then
            movement.y = movement.y + 1 * sgn(end_y - movement.y)
        end
    end

    return movement
end

function new_animation(params)
    local step_length_frames = params.step_length_frames
    local sprites = params.sprites

    local frame_counter = 0
    local loop_length_frames = step_length_frames * #sprites

    local animation = {}

    animation.advance_1_frame = function()
        frame_counter = (frame_counter + 1) % loop_length_frames
    end

    animation.current_sprite = function()
        local sprite_index = 1 + flr(frame_counter / step_length_frames)
        return sprites[sprite_index]
    end

    return animation
end

function new_player(params)
    local x_tile, y_tile = params.x_tile, params.y_tile

    local player = {
        x_tile = x_tile,
        y_tile = y_tile,
        facing_right = true,
        walk_animation = new_animation({
            step_length_frames = 10,
            sprites = {
                u.sprites.player.sprite_1,
                u.sprites.player.sprite_2,
                u.sprites.player.sprite_3,
                u.sprites.player.sprite_4,
            },
        }),
        movement = nil,
    }

    return player
end

local player = new_player({
    x_tile = 1,
    y_tile = 2,
})

function _update60()
    d:update()

    player.walk_animation.advance_1_frame()

    if player.movement then
        if player.movement.has_finished then
            player.movement = nil
        else
            player.movement.advance_1_frame()
        end
    else
        for button, direction in pairs(u.buttons_to_directions) do
            if btnp(button) then
                local next_x, next_y = player.x_tile + direction.x, player.y_tile + direction.y
                local tile = mget(next_x, next_y)
                if not fget(tile, u.flags.non_walkable) then
                    player.movement = new_movement({
                        start_x = player.x_tile * u.tile_edge_length,
                        start_y = player.y_tile * u.tile_edge_length,
                        end_x = next_x * u.tile_edge_length,
                        end_y = next_y * u.tile_edge_length,
                    })
                    player.x_tile = player.x_tile + direction.x
                    player.y_tile = player.y_tile + direction.y
                    if direction.x > 0 then
                        player.facing_right = true
                    elseif direction.x < 0 then
                        player.facing_right = false
                    end
                end
            end
        end
    end
end

function _draw()
    cls()

    map(0, 0, 0, 0, u.screen_edge_tiles, u.screen_edge_tiles)

    palt(u.colors.black, false)
    pal(u.colors.light_grey, u.colors.yellow)
    if player.movement then
        spr(player.walk_animation.current_sprite(),
            player.movement.x,
            player.movement.y,
            1, 1,
            not player.facing_right)
    else
        spr(player.walk_animation.current_sprite(),
            player.x_tile * u.tile_edge_length,
            player.y_tile * u.tile_edge_length,
            1, 1,
            not player.facing_right)
    end
    pal()

    d:draw()
end

-- TODO: wall bump with use of the offset movement logic

-- TODO: non-walkable: door, chest big closed/open, chest small closed/open, vase 1, vase 2, stone tablet
-- TODO: can-interact-with flag: stairs, door, chest big/small closed, vase 1&2, stone tablet
-- TODO: interaction: vase -> no vase
-- TODO: interaction: door -> no door
-- TODO: interaction: stone tablet -> (nothing yet)
-- TODO: interaction: chest closed -> chest open

-- TODO: next button 1-slot buffer to be able to move again during movement animation

-- TODO: SFX for walking
-- TODO: SFX for door open
-- TODO: SFX for chest open
-- TODO: SFX for chest open, but no space in inventory
-- TODO: SFX for vase break

-- TODO: function to draw a window with border with text inside, clipped to not overflow
-- TODO: show text window on stone tablet bump
-- TODO: window size fits text width; text as an array of lines
-- TODO: window appears and disappear in animated way
-- TODO: window disappear on X press
-- TODO: X animated (`SIN(TIME())` might be helpful)
-- TODO: multiple stone tablets with their texts (maybe use last sprite flags as binary number of text?)
