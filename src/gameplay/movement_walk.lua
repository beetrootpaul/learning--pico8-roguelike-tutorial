-- -- -- -- -- -- -- -- -- --
-- gameplay/movement_walk  --
-- -- -- -- -- -- -- -- -- --

function new_movement_walk(params)
    local start_x_offset = params.start_x_tile_offset * u.tile_size
    local start_y_offset = params.start_y_tile_offset * u.tile_size

    local x_offset = start_x_offset
    local y_offset = start_y_offset
    local speed = 2

    local mw = {}

    --

    function mw.has_finished()
        return x_offset == 0 and y_offset == 0
    end

    --

    function mw.offset()
        return {
            x = x_offset,
            y = y_offset,
        }
    end

    --

    function mw.advance_1_frame()
        x_offset = x_offset - sgn(start_x_offset) * speed
        if x_offset * sgn(start_x_offset) < 0 then
            x_offset = 0
        end

        y_offset = y_offset - sgn(start_y_offset) * speed
        if y_offset * sgn(start_y_offset) < 0 then
            y_offset = 0
        end
    end

    --

    return mw
end