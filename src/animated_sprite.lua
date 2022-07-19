function new_animated_sprite(params)
    local step_length_frames = params.step_length_frames
    local sprites = params.sprites

    local frame_counter = 0
    local loop_length_frames = step_length_frames * #sprites

    local animated_sprite = {}

    animated_sprite.advance_1_frame = function()
        frame_counter = (frame_counter + 1) % loop_length_frames
    end

    animated_sprite.current_sprite = function()
        local sprite_index = 1 + flr(frame_counter / step_length_frames)
        return sprites[sprite_index]
    end

    return animated_sprite
end