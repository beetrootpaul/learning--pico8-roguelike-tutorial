function new_player(params)
    local x_tile, y_tile = params.x_tile, params.y_tile

    local player = {
        x_tile = x_tile,
        y_tile = y_tile,
        facing_right = true,
        animated_walk = new_animated_sprite {
            step_length_frames = 10,
            sprites = {
                u.sprites.player.sprite_1,
                u.sprites.player.sprite_2,
                u.sprites.player.sprite_3,
                u.sprites.player.sprite_4,
            },
        },
        movement1 = nil,
        movement2 = nil,
        buffered_button = nil,
    }

    return player
end