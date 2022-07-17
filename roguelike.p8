pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
-- lazy dev's roguelike tutorial
-- beetroot paul's take

#include src/utils.lua
#include src/debug.lua

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
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000006666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000666000aaaaaaa0
0005000066666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aaa00006666600aaaaaaa0
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0aaa0a06000006000000000
05000500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00000a06000006000aaa000
00000000666066600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aaaaaaa066666660a0aaa0a0
00050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00000006000000aa0000
00000000606660600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aaaaaaa066666660a0aaa0a0
__gff__
0000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
2121212121212121212121212121212100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2120202020212020212020202020202100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
210e2020202f20202120202020200f2100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2120202020212020212020202020202100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
21212121212120202121212f2121212100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2120202020202020212020202020202100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2120202020202021212f212121212f2100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2120202d20202021202020212020202100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2120202020202021202020212020202100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2120202020202021202020212020202100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
212121212f212121212f2121212f212100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2120202020202120202021202020202100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
21202020202021202d2021202020202100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2120202020202f2020202f20202d202100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2120202020202120202021202020202100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2121212121212121212121212121212100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000200002d0502d0502c0502a0502905028050184501845019450194501945019450194501d0501c0501b0501a050190501605015040140401303013030140302143021420214202142021410170101700017000
000400002b5502b5402b5401354013530345303451000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100000865000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000200000d7500d740007200070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
