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
