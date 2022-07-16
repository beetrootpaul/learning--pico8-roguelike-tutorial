function new_animation(params)
    local step_length_frames = params.step_length_frames
    local sprites = params.sprites

    local frame_counter = 0
    local loop_length_frames = step_length_frames * #sprites

    local advance_1_frame = function()
        frame_counter = (frame_counter + 1) % loop_length_frames
    end

    local current_sprite = function()
        local sprite_index = 1 + flr(frame_counter / step_length_frames)
        return sprites[sprite_index]
    end

    return {
        advance_1_frame = advance_1_frame,
        current_sprite = current_sprite,
    }
end

local player = {
    x_tile = 3,
    y_tile = 5,
    walk_animation = new_animation({
        step_length_frames = 8,
        sprites = {
            u.sprites.player.sprite_1,
            u.sprites.player.sprite_2,
            u.sprites.player.sprite_3,
            u.sprites.player.sprite_4,
        },
    }),
}

function _init()
end

function _update60()
    d:update()
    player.walk_animation.advance_1_frame()
    if btnp(u.buttons.l) then
        player.x_tile = player.x_tile - 1
    end
    if btnp(u.buttons.r) then
        player.x_tile = player.x_tile + 1
    end
    if btnp(u.buttons.u) then
        player.y_tile = player.y_tile - 1
    end
    if btnp(u.buttons.d) then
        player.y_tile = player.y_tile + 1
    end
end

function _draw()
    cls()
    map(0, 0, 0, 0, u.screen_edge_tiles, u.screen_edge_tiles)
    palt(u.colors.black, false)
    pal(u.colors.light_grey, u.colors.yellow)
    spr(player.walk_animation.current_sprite(),
        player.x_tile * u.tile_edge_length,
        player.y_tile * u.tile_edge_length)
    pal()
    d:draw()
end
