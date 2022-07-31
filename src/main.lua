-- -- -- --
-- main  --
-- -- -- --

--__debug__ = true

local current_gs, next_gs

function _init()
    validations.validate_stone_tablets()

    next_gs = new_gs_level_start {
        status_area = new_status_area(),
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
    pal()
    cls()
    current_gs.draw()
end

-- TODO: SFX on level exit

-- TODO: make damage indicators sequenced one after another when multiple monsters hit player at the same time