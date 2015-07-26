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
  return self
end

function Maze:wall(x, y)
  return self.field[{ x, y, { 1, 4 } }]
end

function Maze:is_exit(x, y)
  return self.field[x][y][5]
end
