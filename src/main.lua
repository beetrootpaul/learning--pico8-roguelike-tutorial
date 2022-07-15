function _init()
end

function _update60()
    d:update()
    d:add_message("it's a me!")
end

function _draw()
    cls(u.colors.dark_blue)
    d:draw()
end
