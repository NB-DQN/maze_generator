require "generator"

Maze = {}
Maze.__index = Maze

setmetatable(Maze, {
  __call = function (cls, ...)
    return cls.new(...)
  end
})

function Maze.new(size)
  local self = setmetatable({}, Maze)
  self.field = generate(size)
  self.size = size
  return self
end

function Maze:wall(cell)
  if cell[1] < 1 or self.size[1] < cell[1] or cell[2] < 1 or self.size[2] < cell[2] then
    error("wrong coordinate")
  end
  return self.field[{ cell[1], cell[2], { 1, 4 } }]
end

function Maze:is_exit(cell)
  if cell[1] < 1 or self.size[1] < cell[1] or cell[2] < 1 or self.size[2] < cell[2] then
    error("wrong coordinate")
  end
  return self.field[cell[1]][cell[2]][5]
end

function Maze:display_cui()
  local str = ""
  for x = 1, self.size[1] do
    for y = 1, self.size[2] do
      str = str .. "8"
      if self.field[x][y][1] == 1 then
        str = str .. "888"
      else
        str = str .. "   "
      end
    end
    str = str .. "8\n"

    for y = 1, self.size[2] do
      if self.field[x][y][4] == 1 then
        str = str .. "8"
      else
        str = str .. " "
      end
      str = str .. "   "
    end
    if self.field[x][self.size[2]][2] == 1 then
      str = str .. "8"
    else
      str = str .. " "
    end
    str = str .. "\n"
  end

  for y = 1, self.size[2] do
    str = str .. "8"
    if self.field[self.size[1]][y][3] == 1 then
      str = str .. "888"
    else
      str = str .. "   "
    end
  end
  str = str .. "8\n"

  print(str)
end
