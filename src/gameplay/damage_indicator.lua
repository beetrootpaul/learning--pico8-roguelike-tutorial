-- -- -- -- -- -- -- -- -- -- --
-- gameplay/damage_indicator  --
-- -- -- -- -- -- -- -- -- -- --

function new_damage_indicator(params)
    local reference_position = params.reference_position

    local x = (reference_position.x_tile + 0.5) * u.tile_size - 1
    local y = reference_position.y_tile * u.tile_size + 2

    local text = "-1"
    local text_w = u.measure_text_width(text)

    local ttl = 16
    local ttl_stop = 12

    local di = {}

    --

    function di.has_finished()
        return ttl <= 0
    end

    --

    function di.advance_1_frame()
        if ttl > ttl_stop then
            y = y - 1
        end
        ttl = max(0, ttl - 1)
    end

    --

    function di.draw(opts)
        print(
            text,
            x - text_w / 2,
            y - u.text_height,
            opts.dim_colors and u.colors.violet_grey or u.colors.orange
        )
    end

    --

    return di
end