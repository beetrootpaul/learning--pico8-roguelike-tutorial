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

    local m = {}

    --

    function m.update()
        animated_walk.advance_1_frame()
    end

    --

    function m.draw(opts)
        if opts.dim_colors then
            pal(a.colors.template, u.colors.violet_grey)
        else
            pal(a.colors.template, u.colors.yellow)
        end
        palt(u.colors.black, false)

        spr(
            animated_walk.current_sprite(),
            x_tile * u.tile_size, -- + offset.x,
            y_tile * u.tile_size -- + offset.y
        )

        pal()
    end

    --

    return m
end