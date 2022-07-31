-- -- -- -- -- -- -- --
-- gui/health_display   --
-- -- -- -- -- -- -- --

function new_health_display(params)
    local health = params.health

    local hd = {}

    --

    function hd.draw(opts)
        if not opts then
            opts = {}
        end

        if opts.dim_colors then
            pal(u.colors.dark_grey, u.colors.dark_blue)
            pal(u.colors.light_grey, u.colors.dark_blue)
            pal(u.colors.white, u.colors.dark_blue)
        end

        rectfill(0, 0, 30, 6, u.colors.light_grey)
        line(1, 0, 29, 0, u.colors.white)
        line(0, 0, 0, 5, u.colors.white)
        line(1, 6, 29, 6, u.colors.dark_grey)
        line(30, 1, 30, 6, u.colors.dark_grey)

        for i = 0, health.max() - 1 do
            if opts.dim_colors then
                pal(a.colors.template, (i < health.current()) and u.colors.black or u.colors.dark_blue)
            else
                pal(a.colors.template, (i < health.current()) and u.colors.purple or u.colors.violet_grey)
            end
            spr(a.sprites.status_heart, 1 + i * 6, 1)
        end

        pal()
    end

    --

    return hd
end