pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
-- lazy dev's roguelike tutorial
-- beetroot paul's take

#include src/global/utils.lua
#include src/global/assets.lua
#include src/global/validations.lua
#include src/global/audio.lua

#include src/game_states/gs_game_over.lua
#include src/game_states/gs_level_start.lua
#include src/game_states/gs_monsters_movement.lua
#include src/game_states/gs_player_movement.lua
#include src/game_states/gs_player_turn.lua
#include src/game_states/gs_reading_stone_tablet.lua

#include src/gui/text_message.lua

#include src/gameplay/animated_sprite.lua
#include src/gameplay/damage_animation.lua
#include src/gameplay/damage_indicator.lua
#include src/gameplay/damage_indicators.lua
#include src/gameplay/level.lua
#include src/gameplay/monster.lua
#include src/gameplay/monsters.lua
#include src/gameplay/movement_bump.lua
#include src/gameplay/movement_walk.lua
#include src/gameplay/player.lua


#include src/main.lua

--[[

glyphs:
q > […]
w > [∧]
e > [░]
r > [➡️]
t > [⧗]
y > [▤]
u > [⬆️]
i > [☉]
o > [🅾️]
p > [◆]
a > [█]
s > [★]
d > [⬇️]
f > [✽]
g > [●]
h > [♥]
j > [웃]
k > [⌂]
l > [⬅️]
z > [▥]
x > [❎]
c > [🐱]
v > [ˇ]
b > [▒]
n > [♪]
m > [😐]

--]]

__gfx__
000000000066600000000000006660000000000000000000000000000000000000000000000000000000000000000000000000000000000055555550000000a0
0000000000060600006660000006060000666000000000000000000000000000000000000000000000000000000000000000000000000000500000000000a0a0
00700700000666000006060000066600000606000000000000000000000000000000000000000000000000000000000000000000000000005000005000a0a0a0
00077000660000600006660006600000000666000000000000000000000000000000000000000000000000000000000000000000000000005000505000a0a0a0
00077000660660606600006006606000066000000000000000000000000000000000000000000000000000000000000000000000000000005050505000a0a0a0
00700700000660006606660000066000066666000000000000000000000000000000000000000000000000000000000000000000000000005050505000a0a000
00000000000600000060060000006000006006000000000000000000000000000000000000000000000000000000000000000000000000005050505000a00000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000066600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000006660000666060000666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000066606000666060006660600066666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000666660600666660066666060666606600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000666666600666660066666660666660600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000066666000066600006666600666666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000006666666000000000000000000000000000000000000000000000000000000000000000000000000000aaa00000aaa0000000000000666000aaaaaaa0
00050000666666600000000000000000000000000000000000000000000000000000000000000000aaaaaaa00a000a000a000a0000aaa00006666600aaaaaaa0
00000000000000000000000000000000000000000000000000000000000000000000000000000000aaaaaaa00a000a000a000a00a0aaa0a06000006000000000
05000500000000000000000000000000000000000000000000000000000000000000000000000000a00a0aa000aaa000a0aaa0a0a00000a06000006000aaa000
00000000666066600000000000000000000000000000000000000000000000000000000000000000aaaaaaa00a000a00aa000aa0aaaaaaa066666660a0aaa0a0
00050000000000000000000000000000000000000000000000000000000000000000000000000000a0a000a00aaaaa00aaaaaaa0000a00000006000000aa0000
00000000606660600000000000000000000000000000000000000000000000000000000000000000aaaaaaa000aaa0000aaaaa00aaaaaaa066666660a0aaa0a0
__gff__
0000000000000000000000000000010100000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
2121212121212121212121212121212121212121212121212121212121212121000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
212020202020212020212c2b20202021212020202020202011202020202b2c21000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
210e01202a202f2020212b2020110f21212d21212f21212121212121212f2121000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
21202020202021202021202020202021212121202020212121212b2120202a21000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
21212121212121202021212f2121212121212020112020212121202f20202021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
21202020202b2c20202120202020202121202020202020202121202120202c21000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2111202020202b2121212f2121212f21212011202d2011202121202121212121000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2120202d20202021202020212b20202121202020202020202121202120202021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2120202011202021202b20212011202121212020112020212121202f20110f21000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2120202020202021202020212020202121212120202021212c212b2120202021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
212121212f212121212f2121212f2121212d21212f21212b2b21212121212121000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
212020202020212020202120202020212120202120212011202f202020202021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
21202020112021202a202120201120212120202f202f2020202120202a202021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
212b2c2020202f2020202f20112d202121212121212121212f21202020202021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
212c2b2b202021202020212020202021210e0120202020202021202020202021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2121212121212121212121212121212121212121212121212121212121212121000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000200001b3401b3401b340223302233022310293001840019400194001940019400194001d0001c0001b0001a000190001600015000140001300013000140002140021400214002140021400170001700017000
000700001f5401f5402b5302b5101f5001f5002b5002b5002b5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100000863000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000200000c7400c730077100070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000700000a0500a0500a0500f050130401303013000130000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300000f6400f5400f5000f20018500107001070013500107001070010700107001070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000800000a33000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000800000633011300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
