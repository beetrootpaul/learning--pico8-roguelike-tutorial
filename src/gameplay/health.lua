-- -- -- -- -- -- -- --
-- gameplay/health   --
-- -- -- -- -- -- -- --

function new_health(params)
    local max_value = params.max

    local current = max_value

    local h = {}

    --

    function h.current()
        return current
    end
    function h.max()
        return max_value
    end

    --

    function h.decrease()
        current = max(0, current - 1)
    end

    --

    function h.is_empty()
        return current == 0
    end

    --

    return h
end