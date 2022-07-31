-- -- -- -- -- -- -- --
-- gameplay/player   --
-- -- -- -- -- -- -- --

function new_player(params)
    local x_tile = params.position.x_tile
    local y_tile = params.position.y_tile

    local is_facing_left = false

    local animated_walk = new_animated_sprite {
        frames_per_sprite = 5,
        sprites_sequence = {
            a.sprites.player_walk_1,
            a.sprites.player_walk_2,
            a.sprites.player_walk_3,
            a.sprites.player_walk_4,
        },
    }

    local movement

    local p = {}

    --

    function p.position()
        return {
            x_tile = x_tile,
            y_tile = y_tile,
        }
    end

    --

    function p.next_position(direction)
        return {
            x_tile = x_tile + (direction and direction.x or 0),
            y_tile = y_tile + (direction and direction.y or 0),
        }
    end

    --

    function p.is_moving()
        return movement
    end

    --

    function p.walk_to(position)
        if x_tile == position.x_tile and y_tile == position.y_tile then
            return
        end

        audio.sfx(a.sounds.sfx_walk)

        if position.x_tile > x_tile then
            is_facing_left = false
        elseif position.x_tile < x_tile then
            is_facing_left = true
        end

        movement = new_movement_walk {
            start_x_tile_offset = x_tile - position.x_tile,
            start_y_tile_offset = y_tile - position.y_tile,
        }

        x_tile = position.x_tile
        y_tile = position.y_tile
    end

    --

    function p.bump(direction)
        if not direction then
            return
        end

        audio.sfx(a.sounds.sfx_bump)

        if direction.x > 0 then
            is_facing_left = false
        elseif direction.x < 0 then
            is_facing_left = true
        end

        movement = new_movement_bump {
            direction = direction,
        }
    end

    --

    function p.animate()
        animated_walk.animate()

        if movement then
            if movement.has_finished() then
                movement = nil
            else
                movement.animate()
            end
        end
    end

    --

    function p.draw(opts)
        if not opts then
            opts = {}
        end

        if opts.dim_colors then
            pal(a.colors.template, u.colors.violet_grey)
        else
            pal(a.colors.template, u.colors.yellow)
        end
        palt(u.colors.black, false)

        local offset = movement and movement.offset() or { x = 0, y = 0 }
        spr(
            animated_walk.current_sprite(),
            x_tile * u.tile_size + offset.x + (is_facing_left and -1 or 0),
            y_tile * u.tile_size + offset.y,
            1,
            1,
            is_facing_left
        )

        pal()
    end

    --

    return p
end