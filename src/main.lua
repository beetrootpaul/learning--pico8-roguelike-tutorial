-- -- -- --
-- main  --
-- -- -- --

__debug__ = true

local gs

function _init()
    u.set_btnp_delay {
        initial = 4,
        repeating = 4,
    }

    validations.validate_stone_tablets()

    gs = new_game_state_gameplay {
        level_number = 1,
    }
end

function _update()
    gs = gs.update()
    audio.play()
end

function _draw()
    cls()
    gs.draw()
end

-- TODO: mob color flash (several frames) to indicate being hit
-- TODO: mob not disappearing immediately on 0 HP, but after delay (but NOT hittable again!)
-- TODO: mob next to player bumps on it and attack
-- TODO: SFX for mob attacking the player
-- TODO: draw monsters first on their turn and second on player turn

-- TODO: death on 0 HP
-- TODO: game over screen
-- TODO: game over screen shown after animation ended (so the reason was visible)
-- TODO: game restart after game over

-- TODO: defeated mob disappears (flashes?) over short time
