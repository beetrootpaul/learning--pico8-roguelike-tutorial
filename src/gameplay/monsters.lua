-- -- -- -- -- -- -- --
-- gameplay/monsters --
-- -- -- -- -- -- -- --

function new_monsters()
    local list = {}

    local function distance_pow2(position_1, position_2)
        local dx = position_1.x_tile - position_2.x_tile
        local dy = position_1.y_tile - position_2.y_tile
        return dx * dx + dy * dy
    end

    local function closest_position(p)
        local available_positions = p.available_positions
        local target_position = p.target_position

        local closest = available_positions[1]
        for position in all(available_positions) do
            if distance_pow2(position, target_position) < distance_pow2(closest, target_position) then
                closest = position
            end
        end
        return closest
    end

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

    function mm.get_monster_on(position)
        for monster in all(list) do
            local p = monster.position()
            if p.x_tile == position.x_tile and p.y_tile == position.y_tile then
                return monster
            end
        end
    end

    --

    function mm.is_any_monster_moving()
        for monster in all(list) do
            if monster.is_moving() then
                return true
            end
        end
        return false
    end

    --

    function mm.walk_to_player(p)
        local player_position = p.player.position()

        local occupied_positions = {
            [player_position.x_tile .. "-" .. player_position.y_tile] = true,
        }

        for monster in all(list) do
            local monster_position = monster.position()
            occupied_positions[monster_position.x_tile .. "-" .. monster_position.y_tile] = true
        end

        for monster in all(list) do
            local monster_position = monster.position()

            local walkable_positions = p.level.walkable_positions_around(monster_position)
            local available_positions = { monster_position }
            for wp in all(walkable_positions) do
                if not occupied_positions[wp.x_tile .. "-" .. wp.y_tile] then
                    add(available_positions, wp)
                end
            end

            local next_position = closest_position {
                available_positions = available_positions,
                target_position = player_position
            }
            occupied_positions[monster_position.x_tile .. "-" .. monster_position.y_tile] = false
            occupied_positions[next_position.x_tile .. "-" .. next_position.y_tile] = true
            monster.walk_to(next_position)
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