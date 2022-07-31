-- This file contains some parts of PICO-8 API, written down and annotated by Beetroot Paul (https://beetrootpaul.com)
--
-- Most of descriptions are copied from the official PICO-8 docs (https://www.lexaloffle.com/dl/docs/pico-8_manual.html),
-- some are copied from PICO-8 Wiki (https://pico-8.fandom.com/wiki/Pico-8_Wikia).
--
-- This file is not intended to be included in PICO-8 game, because it would overwrite
-- PICO-8's global functions. Instead, its only purpose is to help IDE with code completion,
-- function param hints, etc. (as long as your IDE treat this file as part of the project).
--


--- Returns the absolute (positive) value of x
---
--- @param x number
--- @return number
function abs(x)
end

--- Add value VAL to the end of table TBL. Equivalent to: TBL[#TBL + 1] = VAL
---
--- If index is given then the element is inserted at that position.
---
--- @param tbl table
--- @param val any
--- @param index number optional
function add(tbl, val, index)
end

--- DISCOURAGED BECAUSE OF BAD PERFORMANCE, USE PAIRS INSTEAD.
--- Used in FOR loops to iterate over all items in a table (that have a 1-based integer index), in the order they were added.
--- @param tbl table
function all(tbl)
end

--- Get button B state for player PL (default 0)
---
--- If no parameters supplied, returns a bitfield of all 12 button states for player 0 & 1 (P0: bits 0..5 P1: bits 8..13)
---
--- @param b number|string a glyph or from 0 to 5: left, right, up, down, button_o, button_x
--- @param pl number player, from 0 to 7, optional, default: 0
--- @return boolean|number whether button is pressed or not, or a bitfield
function btn(b, pl)
end

--- BTNP is short for "Button Pressed"; Instead of being true when a button is held down,
--- BTNP returns true when a button is down AND it was not down the last frame. It also
--- repeats after 15 frames, returning true every 4 frames after that (at 30fps -- double
--- that at 60fps). This can be used for things like menu navigation or grid-wise player
--- movement.
---
--- The state that BTNP reads is reset at the start of each call to _UPDATE or _UPDATE60,
--- so it is preferable to use BTNP from inside one of those functions.
---
--- Custom delays (in frames 30fps) can be set by poking the following memory addresses:
---
---  - POKE(0X5F5C, DELAY) -- SET THE INITIAL DELAY BEFORE REPEATING. 255 MEANS NEVER REPEAT.
---
---  - POKE(0X5F5D, DELAY) -- SET THE REPEATING DELAY.
---
--- In both cases, 0 can be used for the default behaviour (delays 15 and 4)
---
--- @param b number|string a glyph or from 0 to 5: left, right, up, down, button_o, button_x
--- @param pl number player, from 0 to 7, optional, default: 0
--- @return boolean whether button is pressed or not
function btnp(b, pl)
end

--- Set a screen offset of -x, -y for all drawing operations
---
--- CAMERA() to reset
---
--- @param x number optional in pair with y
--- @param y number optional in pair with x
function camera(x, y)
end

--- Returns the closest integer that is equal to or above x
---
--- @param x number
--- @return number
function ceil(x)
end

--- Draw a circle at x,y with radius r.
---
--- If r is negative, the circle is not drawn.
---
--- @param x number
--- @param y number
--- @param r number
--- @param col number color, optional
function circ(x, y, r, col)
end

--- Draw a filled circle at x,y with radius r.
---
--- If r is negative, the circle is not drawn.
---
--- @param x number
--- @param y number
--- @param r number
--- @param col number color, optional
function circfill(x, y, r, col)
end

--- Sets the screen's clipping region in pixels.
---
--- CLIP() to reset.
---
--- When clip_previous is true, clip the new clipping region by the old one.
---
--- @param x number optional in set with y, w, h
--- @param y number optional in set with x, w, h
--- @param w number optional in set with x, y, h
--- @param h number optional in set with x, y, w
--- @param clip_previous boolean, optional
function clip(x, y, w, h, clip_previous)
end

--- Clear the screen and reset the clipping rectangle.
--- @param col number optional, default: black
function cls(col)
end

--- Delete the first instance of value VAL in table TBL.
---
--- The remaining entries are shifted left one index to avoid holes.
---
--- Note that VAL is the value of the item to be deleted, not the index into the table.
--- (To remove an item at a particular index, use DELI instead).
--- DEL returns the deleted item, or returns no value when nothing was deleted.
---
--- @param tbl table
--- @param val any value to be deleted
function del(tbl, val)
end

--- Like DEL(), but remove the item from table TBL at index I When I is not given, the last element of the table is removed and returned.
---
--- @param tbl table
--- @param i number index, optional
function deli(tbl, i)
end

--- Special system command, where CMD_STR is a string:
---
--- - "pause" - request the pause menu be opened\n
---
--- - "reset" - request a cart reset\n
---
--- - "go_back" - return to the previous cart if there is one
---
--- - "label" - set cart label
---
--- - "screen" - save a screenshot
---
--- - "rec" - set video start point
---
--- - "rec_frames" - set video start point in frames mode
---
--- - "video" - save a .gif to desktop
---
--- - "audio_rec" - start recording audio
---
--- - "audio_end" - save recorded audio to desktop (no supported from web)
---
--- - "shutdown" - quit cartridge (from exported binary)
---
--- - "folder" - open current working folder on the host operating system
---
--- - "set_filename" - set the filename for screenshots / gifs / audio recordings
---
--- - "set_title"     set the host window title
---
--- Some commands have optional number parameters:
---
--- - "video" and "screen": P1: an integer scaling factor that overrides the system setting. P2: when > 0, save to the current folder instead of to desktop
---
--- - "audio_end" P1: when > 0, save to the current folder instead of to desktop
---
--- @param cmdstr string
--- @param p1 number
--- @param p2 number
function extcmd(cmdstr, p1, p2)
end

--- Get the value of sprite N's flag F.
--- When F is omitted, all flags are retrieved/set as a single bitfield.
---
--- @param n number sprite
--- @param f number flag index, from 0 to 7, optional
--- @return boolean whether flag is set or not
function fget(n, f)
end

--- Returns the closest integer that is equal to or below x
---
--- @param x number
--- @return number
function flr(x)
end

--- Draw a line from (X0, Y0) to (X1, Y1).
---
--- If (X1, Y1) are not given, the end of the last drawn line is used.
---
--- @param x0 number
--- @param y0 number
--- @param x1 number optional in pair with y1
--- @param y1 number optional in pair with x1
--- @param col number color, optional
function line(x0, y0, x1, y1, col)
end

--- Draw section of map (starting from CELL_X, CELL_Y) at screen position SX, SY (pixels).
--- @param cell_x number optional
--- @param cell_y number
--- @param sx number optional in pair with sy
--- @param sy number optional in pair with sx
--- @param cell_w number optional in pair with cell_h, default: 128
--- @param cell_h number optional in pair with cell_w, default: 32, which is top half of the map
--- @param layers number a bitfield of sprites' flags to match, optional
function map(cell_x, cell_y, sx, sy, cell_w, cell_h, layers)
end

--- Returns the maximum value of parameters
--- @param x number
--- @param y number
--- @return number
function max(x, y)
end

--- Returns the middle value of parameters
--- @param x number
--- @param y number
--- @param z number
--- @return number
function mid(x, y, z)
end

--- Returns the minimum value of parameters
--- @param x number
--- @param y number
function min(x, y)
end

--- Get map value at X,Y
--- @param x number map cell X
--- @param y number map cell Y
--- @return number map value (sprite), 0 if outside of the map range
function mget(x, y)
end

--- Set map value (VAL) at X,Y
--- @param x number map cell X
--- @param y number map cell Y
--- @param val number map value (sprite)
function mset(x, y, val)
end

--- Used in FOR loops to iterate over table TBL, providing both the key and value for each item.
---
--- Unlike ALL(), PAIRS() iterates over every item regardless of indexing scheme. Order is not guaranteed.
---
--- @param tbl table
function pairs(tbl)
end

--- PAL() swaps colour c0 for c1 for one of three palette re-mappings (p defaults to 0):
---
--- - 0: Draw Palette
---
---   The draw palette re-maps colours when they are drawn. For example, an orange flower sprite can be drawn as a red flower by setting the 9th palette value to 8:
---   PAL(9,8) -- draw subsequent orange (colour 9) pixels as red (colour 8) SPR(1,70,60) -- any orange pixels in the sprite will be drawn with red instead
---
---   Changing the draw palette does not affect anything that was already drawn to the screen.
---
--- - 1: Display Palette
---
---   The display palette re-maps the whole screen when it is displayed at the end of a frame. For example, if you boot PICO-8 and then type PAL(6,14,1),
---   you can see all of the gray (colour 6) text immediate change to pink (colour 14) even though it has already been drawn.
---   This is useful for screen-wide effects such as fading in/out.
---
--- - 2: Secondary Palette
---
---   Used by FILLP() for drawing sprites. This provides a mapping from a single 4-bit colour index to two 4-bit colour indexes.
---
--- PAL() resets all palettes to system defaults (including transparency values) PAL(P) resets a particular palette (0..2) to system defaults
---
--- @param c0 number|table color to swap from or table of colors to swap to (where table index is color to swap from, with an extra "[0]=" to swap from black, because tables are 1-based)
--- @param c1 number color to swap to, absent if c0 is a table
--- @param p number palette re-mapping mode (0, 1, 2), optional, default: 0
function pal(c0, c1, p)
end

--- Set transparency for colour index to T (boolean). Transparency is observed by SPR(), SSPR(), MAP() AND TLINE()
---
--- PALT() resets to default: all colours opaque except colour 0.
---
--- When C is the only parameter, it is treated as a bitfield used to set all 16 values. For example: to set colours 0 and 1 as transparent:
---
--- @param c number color to set transparency for
--- @param t boolean whether color should be treated as transparent or not, optional
function palt(c, t)
end

--- Print a string STR and optionally set the draw colour to COL.
--- @param str string text to print
--- @param x number
--- @param y number
--- @param col number color
--- @return number the right-most x position that occurred while printing
function print(str, x, y, col)
end

--- Print a string to the host operating system's console for debugging.
---
--- If filename is set, append the string to a file on the host operating system (in the current directory by default -- use FOLDER to view).
---
--- Setting OVERWRITE to true causes that file to be overwritten rather than appended.
---
--- Setting SAVE_TO_DESKTOP to true saves to the desktop instead of the current path.
---
--- Use a filename of "@clip" to write to the host's clipboard.
---
--- @param str string text to print
--- @param filename string optional
--- @param overwrite boolean optional
--- @param save_to_desktop boolean optional
function printh(str, filename, overwrite, save_to_desktop)
end

--- Draw a rectangle with corners at (X0, Y0), (X1, Y1).
--- @param x0 number top-left corner
--- @param y0 number top-left corner
--- @param x1 number bottom-right corner
--- @param y1 number bottom-right corner
--- @param col number color, optional
function rect(x0, y0, x1, y1, col)
end

--- Draw a filled rectangle with corners at (X0, Y0), (X1, Y1).
--- @param x0 number top-left corner
--- @param y0 number top-left corner
--- @param x1 number bottom-right corner
--- @param y1 number bottom-right corner
--- @param col number color, optional
function rectfill(x0, y0, x1, y1, col)
end

--- Same as MEMCPY, but copies from cart rom.
---
--- The code section ( >= 0x4300) is protected and can not be read.
---
--- If filename specified, load data from a separate cartridge. In this case, the cartridge must be local (BBS carts can not be read in this way).
---
--- @param dest_addr number
--- @param source_addr number
--- @param len number
--- @param filename string optional
function reload(dest_addr, source_addr, len, filename)
end

--- Returns a random number n, where 0 <= n < x
---
--- If you want an integer, use flr(rnd(x)).
---
--- If x is an array-style table, return a random element between table[1]
--- and table[#table].
---
--- @param x number|table
function rnd(x)
end

--- Returns the sign of a number, 1 for positive, -1 for negative
---
--- SGN(0) will return 1, not 0 as might be common on other platforms.
---
--- @param x number The number to determine the sign of, optional
--- @return number either 1 or -1
function sgn(x)
end

--- Returns the cosine or sine of x, where 1.0 means a full turn.
---
--- PICO-8's SIN() returns an inverted result to suit screenspace (where Y means "DOWN", as opposed to mathematical diagrams where Y typically means "UP").
---
--- > SIN(0.25) -- RETURNS -1
---
--- To get conventional radian-based trig functions without the y inversion, paste the following snippet near the start of your program:
---
--- > P8COS = COS FUNCTION COS(ANGLE) RETURN P8COS(ANGLE/(3.1415*2)) END
---
--- > P8SIN = SIN FUNCTION SIN(ANGLE) RETURN -P8SIN(ANGLE/(3.1415*2)) END
---
--- @param x number
--- @return number
function sin(x)
end

--- Play sfx N (0..63) on CHANNEL (0..3) from note OFFSET (0..31 in notes) for LENGTH notes.
---
--- Using negative CHANNEL values have special meanings:
---
--- - CHANNEL -1: (default) to automatically choose a channel that is not being used
---
--- - CHANNEL -2: to stop the given sound from playing on any channel
---
--- N can be a command for the given CHANNEL (or all channels when CHANNEL < 0):
---
--- - N -1: to stop sound on that channel
---
--- - N -2: to release sound on that channel from looping
---
--- @param n number index of SFX to play
--- @param channel number optional, default: -1
--- @param offset number
--- @param length number
function sfx(n, channel, offset, length)
end

--- Split a string into a table of elements delimited by the given separator (defaults to ",").
--- When separator is a number n, the string is split into n-character groups.
--- When convert_numbers is true, numerical tokens are stored as numbers (defaults to true).
--- Empty elements are stored as empty strings.
---
--- @param str string
--- @param separator string, optional, default: ","
--- @param convert_numbers boolean, optional, default: true
--- @return table
function split(str, separator, convert_numbers)
end

--- Draw sprite N (0..255) at position X,Y
---
--- @param n number
--- @param x number
--- @param y number
--- @param w number how many sprites to blit, optional in pair with h, default: 1
--- @param h number how many sprites to blit, optional in pair with w, default: 1
--- @param flip_x boolean
--- @param flip_y boolean
function spr(n, x, y, w, h, flip_x, flip_y)
end

--- Return the square root of x
---
--- @param x number
--- @return number
function sqrt(x)
end

--- Grab a substring from string str, from pos0 up to and including pos1.
--- When POS1 is not specified, the remainder of the string is returned.
--- When POS1 is specified, but not a number, a single character at POS0 is returned.
---
--- @param str string
--- @param pos0 number
--- @param pos1 number optional
--- @return table
function sub(str, pos0, pos1)
end

--- Returns the number of seconds elapsed since the cartridge was run.
---
--- This is not the real-world time, but is calculated by counting the number of times _UPDATE or @_UPDATE60 is called.
--- Multiple calls of TIME() from the same frame return the same result.
---
--- @return number
function time()
end

--- Same as TIME()
---
--- @return number
function t()
end

--- Convert VAL to a string.
---
--- FORMAT_FLAGS is a bitfield:
---
---  - 0x1: Write the raw hexadecimal value of numbers, functions or tables.
---
---  - 0x2: Write VAL as a signed 32-bit integer by shifting it left by 16 bits.
---
--- TOSTR(NIL) returns "[nil]"
---
--- TOSTR() returns ""
---
--- @param val any
--- @param format_flags number bitfield, optional
--- @return string
function tostr(val, format_flags)
end