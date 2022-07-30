-- -- -- -- -- -- -- -- -- -- --
-- gameplay/animated_sprite   --
-- -- -- -- -- -- -- -- -- -- --

function new_animated_sprite(params)
    local frames_per_sprite = params.frames_per_sprite
    local sprites_sequence = params.sprites_sequence

    local frame_counter = 0
    local loop_length_frames = frames_per_sprite * #sprites_sequence

    local as = {}

    --

    function as.advance_1_frame()
        frame_counter = (frame_counter + 1) % loop_length_frames
    end

    --

    function as.current_sprite()
        local sprite_index = 1 + flr(frame_counter / frames_per_sprite)
        return sprites_sequence[sprite_index]
    end

    --

    return as
end