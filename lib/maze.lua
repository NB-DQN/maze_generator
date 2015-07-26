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
  self.field = generate_field(size_x, size_y)
  return self
end
