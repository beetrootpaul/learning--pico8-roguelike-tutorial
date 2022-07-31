-- -- -- -- -- -- -- -- -- -- --
-- game_states/gs_level_start --
-- -- -- -- -- -- -- -- -- -- --

function new_gs_level_start(params)
    local level_number = params.level_number

    local level
    local player
    local monsters

    local ttl_max = 8
    local ttl = ttl_max

    local initialized = false

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

        initialized = true
    end

    local gs = {}

    --

    function gs.update()
        local next_gs = gs

        if not initialized then
            init()
        end

        ttl = max(0, ttl - 1)

        if ttl <= 0 then
            next_gs = new_gs_player_turn {
                level = level,
                player = player,
                monsters = monsters,
                damage_indicators = new_damage_indicators(),
            }
        end

        player.animate()
        monsters.animate()

        return next_gs
    end

    --

    function gs.draw()
        level.draw()
        monsters.draw()
        player.draw()

        u.darken_display_colors {
            steps = ceil(4 * ttl / ttl_max)
        }

        if __debug__ then
            u.print_with_outline("gs_level_start", 1, 1, u.colors.orange, u.colors.dark_blue)
        end
    end

    --

    return gs
end