-- -- -- -- -- -- -- -- --
-- global/validations   --
-- -- -- -- -- -- -- -- --

validations = {}

function validations.validate_stone_tablets()
    for serialized_map_cell, _ in pairs(a.stone_tablet_texts) do
        local map_x = split(serialized_map_cell, "-")[1]
        local map_y = split(serialized_map_cell, "-")[2]
        local sprite = mget(map_x, map_y)
        assert(
            sprite == a.sprites.stone_tablet,
            "no stone tablet found at map cell (" .. map_x .. "," .. map_y .. "). found sprite " .. sprite .. " instead"
        )
    end
    for map_x = 0, u.map_space_w - 1 do
        for map_y = 0, u.map_space_h - 1 do
            if mget(map_x, map_y) == a.sprites.stone_tablet then
                assert(
                    a.stone_tablet_texts[map_x .. "-" .. map_y],
                    "no text defined for stone tablet at map cell (" .. map_x .. "," .. map_y .. ")"
                )
            end
        end
    end
end
