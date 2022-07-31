-- -- -- -- -- -- -- -- -- -- --
-- gameplay/damage_animation  --
-- -- -- -- -- -- -- -- -- -- --

function new_damage_animation(params)
    local default_color = params.default_color

    local ttl = 8
    local ttl_start_indication = 4

    local da = {}

    --

    function da.has_finished()
        return ttl <= 0
    end
    --

    function da.animate()
        ttl = max(0, ttl - 1)
    end

    --

    function da.current_color()
        return (ttl <= ttl_start_indication) and u.colors.orange or default_color
    end


    --

    return da
end