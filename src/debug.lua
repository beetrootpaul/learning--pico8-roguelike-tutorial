-- TODO: refactor to `d = new_debug()`, get rid of `d:…` calls

local debug = {
    _enabled = false,
    _messages = {},
}
d = debug

local messages_offset_x = 1
local messages_offset_y = 1

-- Call it before other "update()" calls, because it clears the message,
-- which might be set in those other functions.
function debug:update()
    if btnp(u.buttons.o) then
        self._enabled = not self._enabled
    end
    self._messages = {}
end

-- Call it after other "draw()" calls, because it prints the message
-- on top of everything else drawn by other functions.
function debug:draw()
    if not self._enabled then
        return
    end
    for i, msg in pairs(self._messages) do
        print(msg,
            messages_offset_x, messages_offset_y + i * (u.text_height_px + 1),
            u.colors.white)
        printh(msg)
    end
end

function debug:add_message(message)
    add(self._messages, message)
end
