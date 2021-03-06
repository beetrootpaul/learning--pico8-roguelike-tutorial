-- -- -- -- -- -- -- -- -- -- --
-- game_states/gs_level_end --
-- -- -- -- -- -- -- -- -- -- --

function new_gs_level_end(params)
    local player_health = params.player_health
    local level = params.level
    local player = params.player
    local monsters = params.monsters
    local damage_indicators = params.damage_indicators
    local next_level_number = params.next_level_number

    local health_display = new_health_display {
        health = player_health,
    }

    local ttl_max = 8
    local ttl = ttl_max

    local gs = {}

    --

    function gs.update()
        local next_gs = gs

        ttl = max(0, ttl - 1)

        if ttl <= 0 then
            if next_level_number then
                next_gs = new_gs_level_start {
                    player_health = player_health,
                    level_number = next_level_number,
                }
            else
                next_gs = new_gs_game_over()
            end
        end

        monsters.remove_dead()

        player.animate()
        monsters.animate()
        damage_indicators.animate()

        return next_gs
    end

    --

    function gs.draw()
        level.draw()
        player.draw()
        monsters.draw()
        damage_indicators.draw()

        health_display.draw()

        u.darken_display_colors {
            steps = ceil(4 * (1 - ttl / ttl_max))
        }

        if __debug__ then
            u.print_with_outline("gs_level_end", 1, 1, u.colors.brown, u.colors.dark_blue)
        end
    end

    --

    return gs
end