-- -- -- -- -- -- -- --
-- gameplay/monsters --
-- -- -- -- -- -- -- --

function new_monsters()
    local list = {}

    local mm = {}

    --

    function mm.add(position)
        if __debug__ then
            printh("adding a monster on " .. position.x_tile .. "," .. position.y_tile)
        end
        add(list, new_monster {
            position = position,
        })
    end

    --

    function mm.remove(monster)
        del(list, monster)
    end

    --

    function mm.get_monster_on(position)
        for monster in all(list) do
            local p = monster.position()
            if p.x_tile == position.x_tile and p.y_tile == position.y_tile then
                return monster
            end
        end
    end

    --

    function mm.update()
        for monster in all(list) do
            if monster.is_dead() then
                del(list, monster)
            else
                monster.update()
            end
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