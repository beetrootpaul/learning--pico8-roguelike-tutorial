-- -- -- -- -- -- --
-- global/audio   --
-- -- -- -- -- -- --

audio = (function()
    local pico8_sfx = sfx

    sfx = function()
        assert(false, "please call 'audio.sfx(sfx_asset)' instead of calling 'sfx' directly")
    end

    local next_sfx_asset

    local a = {}

    --

    function a.sfx(sfx_asset)
        if not next_sfx_asset then
            next_sfx_asset = sfx_asset
        else
            next_sfx_asset = (next_sfx_asset.priority > sfx_asset.priority) and next_sfx_asset or sfx_asset
        end
    end

    --

    function a.play()
        if next_sfx_asset then
            pico8_sfx(next_sfx_asset.track)
            next_sfx_asset = nil
        end
    end

    --

    return a
end)()
