local player = {
    x = 3,
    y = 5,
    animation_cycle_frames = 32,
    animation_frame_counter = 0,
    animation_sprites = {
        u.sprites.player.sprite_1,
        u.sprites.player.sprite_2,
        u.sprites.player.sprite_3,
        u.sprites.player.sprite_4,
    }
}

function _init()
end

function _update60()
    d:update()
    player.animation_frame_counter = (player.animation_frame_counter + 1) % player.animation_cycle_frames
    if btnp(u.buttons.l) then
        player.x = player.x - 1
    end
    if btnp(u.buttons.r) then
        player.x = player.x + 1
    end
    if btnp(u.buttons.u) then
        player.y = player.y - 1
    end
    if btnp(u.buttons.d) then
        player.y = player.y + 1
    end
end

function _draw()
    cls()
    map(0, 0, 0, 0, u.screen_edge_tiles, u.screen_edge_tiles)
    palt(u.colors.black, false)
    pal(u.colors.light_grey, u.colors.yellow)
    local player_sprite_index = 1 + flr(player.animation_frame_counter / (player.animation_cycle_frames / #player.animation_sprites))
    spr(player.animation_sprites[player_sprite_index],
        player.x * u.tile_edge_length,
        player.y * u.tile_edge_length)
    pal()
    d:draw()
end
