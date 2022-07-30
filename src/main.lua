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

-- TODO: make better SFXs

-- TODO: vase SFX
-- TODO: stone tablet SFX

-- TODO: slime mob in an array of mobs to draw
-- TODO: animated slime mob
-- TODO: cannot walk on a mob
-- TODO: bump on a mob => 1 attack point, if mob's HP goes to 0, the mob disappear
-- TODO: SFX of attack hit
-- TODO: mob color flash (several frames) to indicate being hit
-- TODO: "-1" floating above mob (and stopping at some Y for couple of frames) on every hit
-- TODO: mob not disappearing immediately on 0 HP, but after delay (but NOT hittable again!)
-- TODO: mob placed on a level based on a mob tiles placed on a map
-- TODO: mobs move to tiles closer to player (by comparing distance)
-- TODO: mobs do not move onto walls
-- TODO: (extra from me) mobs do not move to worse tile, if there are only worse neighbours, but stay on a tile they are
-- TODO: mob next to player bumps on it and attack
-- TODO: SFX for mob attacking the player

-- TODO: death on 0 HP
-- TODO: game over screen
-- TODO: game over screen shown after animation ended (so the reason was visible)
-- TODO: game restart after game over

-- TODO: defeated mob disappears (flashes?) over short time
