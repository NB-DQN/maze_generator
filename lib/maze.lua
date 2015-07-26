require "generator"

Maze = {}
Maze.__index = Maze

setmetatable(Maze, {
  __call = function (cls, ...)
    return cls.new(...)
  end
})

function Maze.new(size_x, size_y)
  local self = setmetatable({}, Maze)
  self.field = generate(size_x, size_y)
  self.size_x = size_x
  self.size_y = size_y
  return self
end

function Maze:wall(x, y)
  if x < 1 or self.size_x < x or y < 1 or self.size_y < y then
    error("wrong coordinate")
  end
  return self.field[{ x, y, { 1, 4 } }]
end

function Maze:is_exit(x, y)
  if x < 1 or self.size_x < x or y < 1 or self.size_y < y then
    error("wrong coordinate")
  end
  return self.field[x][y][5]
end

function Maze:display_cui()
  local str = ""
  for x = 1, self.size_x do
    for y = 1, self.size_y do
      str = str .. "8"
      if self.field[x][y][1] == 1 then
        str = str .. "888"
      else
        str = str .. "   "
      end
    end
    str = str .. "8\n"

    for y = 1, self.size_y do
      if self.field[x][y][4] == 1 then
        str = str .. "8"
      else
        str = str .. " "
      end
      str = str .. "   "
    end
    if self.field[x][self.size_y][2] == 1 then
      str = str .. "8"
    else
      str = str .. " "
    end
    str = str .. "\n"
  end

  for y = 1, self.size_y do
    str = str .. "8"
    if self.field[self.size_x][y][3] == 1 then
      str = str .. "888"
    else
      str = str .. "   "
    end
  end
  str = str .. "8\n"

  print(str)
end
