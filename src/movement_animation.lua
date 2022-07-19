function new_movement_animation(params)
    local start_x, start_y = params.start_x, params.start_y
    local end_x, end_y = params.end_x, params.end_y

    local movement_animation = {
        x = start_x,
        y = start_y,
        has_finished = false
    }

    movement_animation.advance_1_frame = function()
        if movement_animation.x == end_x and movement_animation.y == end_y then
            movement_animation.has_finished = true
        end
        if movement_animation.x ~= end_x then
            movement_animation.x = movement_animation.x + 1 * sgn(end_x - movement_animation.x)
        end
        if movement_animation.y ~= end_y then
            movement_animation.y = movement_animation.y + 1 * sgn(end_y - movement_animation.y)
        end
    end

    return movement_animation
end
