-- -- -- -- -- -- -- -- -- -- --
-- game_states/gs_level_start --
-- -- -- -- -- -- -- -- -- -- --

function new_gs_level_start(params)
    local level_number = params.level_number

    local level
    local player
    local monsters

    local function init()
        level = new_level {
            level_number = level_number,
        }

        local player_position = level.get_and_clear_initial_player_position()
        player = new_player {
            position = player_position,
        }

        monsters = new_monsters()
        local monster_positions = level.get_and_clear_initial_monster_positions()
        for monster_position in all(monster_positions) do
            monsters.add(monster_position)
        end
    end

    local initialized = false

    local gs = {}

    --

    function gs.update()
        if not initialized then
            init()
        end

        player.animate()
        monsters.animate()

        return new_gs_player_turn {
            level = level,
            player = player,
            monsters = monsters,
            damage_indicators = new_damage_indicators(),
        }
    end

    --

    function gs.draw()
        level.draw()
        monsters.draw()
        player.draw()

        if __debug__ then
            u.print_with_outline("gs_level_start", 1, 1, u.colors.orange, u.colors.dark_blue)
        end
    end

    --

    return gs
end