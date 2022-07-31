-- -- -- -- -- -- -- --
-- gameplay/monster  --
-- -- -- -- -- -- -- --

function new_monster(params)
    local x_tile = params.position.x_tile
    local y_tile = params.position.y_tile

    local animated_walk = new_animated_sprite {
        frames_per_sprite = 5,
        sprites_sequence = {
            a.sprites.monster_slime_1,
            a.sprites.monster_slime_2,
            a.sprites.monster_slime_3,
            a.sprites.monster_slime_4,
        },
    }

    local movement
    local damage_animation

    local health = 2

    local m = {}

    --

    function m.position()
        return {
            x_tile = x_tile,
            y_tile = y_tile,
        }
    end

    --

    --- @return boolean whether damage happened or not
    function m.receive_damage()
        if health <= 0 then
            return false
        end

        audio.sfx(a.sounds.sfx_hit_monster)

        health = max(0, health - 1)

        damage_animation = new_damage_animation {
            default_color = u.colors.yellow
        }

        return true
    end

    --

    function m.is_dead()
        if damage_animation and not damage_animation.has_finished() then
            return false
        end
        return health <= 0
    end

    --

    function m.is_moving()
        return movement
    end

    --

    function m.walk_to(position)
        if x_tile == position.x_tile and y_tile == position.y_tile then
            return
        end

        movement = new_movement_walk {
            start_x_tile_offset = x_tile - position.x_tile,
            start_y_tile_offset = y_tile - position.y_tile,
        }

        x_tile = position.x_tile
        y_tile = position.y_tile
    end

    --

    function m.animate()
        animated_walk.animate()

        if movement then
            if movement.has_finished() then
                movement = nil
            else
                movement.animate()
            end
        end

        if damage_animation then
            if damage_animation.has_finished() then
                damage_animation = nil
            else
                damage_animation.animate()
            end
        end
    end

    --

    function m.draw(opts)
        if opts.dim_colors then
            pal(a.colors.template, u.colors.violet_grey)
        elseif damage_animation then
            pal(a.colors.template, damage_animation.current_color())
        else
            pal(a.colors.template, u.colors.yellow)
        end
        palt(u.colors.black, false)

        local offset = movement and movement.offset() or { x = 0, y = 0 }
        spr(
            animated_walk.current_sprite(),
            x_tile * u.tile_size + offset.x,
            y_tile * u.tile_size + offset.y
        )

        pal()
    end

    --

    return m
end