-- -- -- -- -- -- -- -- -- --
-- gameplay/movement_bump  --
-- -- -- -- -- -- -- -- -- --

function new_movement_bump(params)
    -- we copy individual x and y values here and we don't copy reference to "direction",
    -- because later on we modify x and y and don't want to modify it outside this function
    local direction_x = params.direction.x
    local direction_y = params.direction.y

    local x_offset = 0
    local y_offset = 0
    local x_offset_max = direction_x * 2
    local y_offset_max = direction_y * 2

    local speed = 2

    local mb = {}

    --

    function mb.has_finished()
        return direction_x == 0 and direction_y == 0
    end

    --

    function mb.offset()
        return {
            x = x_offset,
            y = y_offset,
        }
    end

    --

    function mb.animate()
        x_offset = x_offset + direction_x * speed
        if x_offset * sgn(x_offset_max) > x_offset_max * sgn(x_offset_max) then
            x_offset = x_offset_max
            direction_x = -direction_x
        end
        if x_offset * sgn(x_offset_max) < 0 then
            x_offset = 0
            direction_x = 0
        end

        y_offset = y_offset + direction_y * speed
        if y_offset * sgn(y_offset_max) > y_offset_max * sgn(y_offset_max) then
            y_offset = y_offset_max
            direction_y = -direction_y
        end
        if y_offset * sgn(y_offset_max) < 0 then
            y_offset = 0
            direction_y = 0
        end
    end

    --

    return mb
end