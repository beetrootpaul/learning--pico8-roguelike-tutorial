-- -- -- --
-- main  --
-- -- -- --

--__debug__ = true

local current_gs, next_gs

function _init()
    u.set_btnp_delay {
        initial = 4,
        repeating = 4,
    }

    validations.validate_stone_tablets()

    next_gs = new_gs_level_start {
        level_number = 1,
    }
end

function _update()
    -- we intentionally reassign game state on the next "_update()" call,
    -- because we need the previous one to be there for "_draw()", while
    -- the next one might be still not ready for drawing before its first
    -- "update()" call
    current_gs = next_gs
    next_gs = current_gs.update()
    audio.play()
end

function _draw()
    cls()
    current_gs.draw()
end

-- TODO: mob next to player bumps on it and attack
-- TODO: SFX for mob attacking the player

-- TODO: death on 0 HP
-- TODO: game over screen
-- TODO: game over screen shown after animation ended (so the reason was visible)
-- TODO: game restart after game over

-- TODO: defeated mob disappears (flashes?) over short time

-- TODO: SFX on level exit
