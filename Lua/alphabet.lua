-- alphabet.lua by Marilyn (mysticrealmcommunityedition @ Discord)
-- Rawsets the entire alphabet, this is redundant because nothing is changed.

local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

for i=0, string.len(alphabet)-1 do
  local letter = string.sub(alphabet, i+1, i+1)
  rawset(_G, letter, i)
  rawset(_G, string.lower(letter), i+36)
end

-- Now you know your ABCs, next time won't you rawset with me?
