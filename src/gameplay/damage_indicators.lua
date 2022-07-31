-- -- -- -- -- -- -- -- -- -- --
-- gameplay/damage_indicators --
-- -- -- -- -- -- -- -- -- -- --

function new_damage_indicators()
    local list = {}

    local dii = {}

    --

    function dii.add_above(position)
        add(list, new_damage_indicator {
            reference_position = position,
        })
    end

    --

    function dii.animate()
        for indicator in all(list) do
            if indicator.has_finished() then
                del(list, indicator)
            else
                indicator.animate()
            end
        end
    end

    --

    function dii.draw(opts)
        if not opts then
            opts = {}
        end

        for indicator in all(list) do
            indicator.draw {
                dim_colors = opts.dim_colors,
            }
        end
    end

    --

    return dii
end