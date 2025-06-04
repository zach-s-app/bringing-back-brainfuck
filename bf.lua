local fname = arg[1]
if not fname then print("Usage: lua run.bf file.bf") os.exit() end

local file = io.open(fname, "r")
local code = file:read("*a"):gsub("[^%+%-%<%>%[%]%,%.]", "")
file:close()

local tape, ptr, pc, stack = {}, 1, 1, {}
for i=1, 30000 do tape[i]=0 end

while pc <= #code do
  local c = code:sub(pc, pc)
  if c == '>' then ptr = ptr + 1
  elseif c == '<' then ptr = ptr - 1
  elseif c == '+' then tape[ptr] = (tape[ptr] + 1) % 256
  elseif c == '-' then tape[ptr] = (tape[ptr] - 1) % 256
  elseif c == '.' then io.write(string.char(tape[ptr]))
  elseif c == ',' then tape[ptr] = 0
  elseif c == '[' then
    if tape[ptr] == 0 then
      local depth = 1
      while depth > 0 do
        pc = pc + 1
        local ch = code:sub(pc, pc)
        if ch == '[' then depth = depth + 1 end
        if ch == ']' then depth = depth - 1 end
      end
    else table.insert(stack, pc) end
  elseif c == ']' then
    if tape[ptr] ~= 0 then
      pc = stack[#stack]
    else table.remove(stack) end
  end
  pc = pc + 1
end

