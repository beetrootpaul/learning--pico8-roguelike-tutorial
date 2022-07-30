-- -- -- -- -- -- -- --
-- gameplay/monsters --
-- -- -- -- -- -- -- --

function new_monsters()
    local list = {}

    local mm = {}

    --

    function mm.add_monster(position)
        if __debug__ then
            printh("adding a monster on " .. position.x_tile .. "," .. position.y_tile)
        end
        add(list, new_monster {
            position = position,
        })
    end

    --

    function mm.update()
        for monster in all(list) do
            monster.update()
        end
    end

    --

    function mm.draw(opts)
        for monster in all(list) do
            monster.draw {
                dim_colors = opts.dim_colors,
            }
        end
    end

    --

    return mm
end