function generate(size_x, size_y)
  local field_x = size_x * 2 + 3
  local field_y = size_y * 2 + 3

  local field = torch.ShortTensor(field_x, field_y):zero()
  field[{ { 2, field_x - 1 }, { 2, field_y - 1 } }] = 9

  local start_cell = { math.floor(torch.uniform(1, size_x)) * 2 + 1, math.floor(torch.uniform(1, size_y)) * 2 + 1 }
  field[start_cell] = 0
  local active_cells = { start_cell }

  -- main backtracking loop
  while #active_cells > 0 do
    local current_cell = active_cells[#active_cells]
    local next_cell

    local candidate_cells = {
      { { current_cell[1] - 2, current_cell[2]     }, { current_cell[1] - 1, current_cell[2]     } },
      { { current_cell[1],     current_cell[2] + 2 }, { current_cell[1],     current_cell[2] + 1 } },
      { { current_cell[1] + 2, current_cell[2]     }, { current_cell[1] + 1, current_cell[2]     } },
      { { current_cell[1],     current_cell[2] - 2 }, { current_cell[1],     current_cell[2] - 1 } },
    }
    local candidates = {}
    for direction = 1, 4 do
      if field[candidate_cells[direction][1]] == 9 then
        candidates[#candidates + 1] = direction
      end
    end

    if #candidates > 0 then
      local direction = candidates[math.floor(torch.uniform(1, #candidates + 1))]
      local next_cell = candidate_cells[direction][1]
      field[next_cell] = 0
      active_cells[#active_cells + 1] = next_cell
      field[candidate_cells[direction][2]] = 0
    else
      active_cells[#active_cells] = nil
    end
  end

  -- create exit
  local periphery = {}
  for x = 3, field_x - 2, 2 do
    periphery[#periphery + 1] = { { x,           3 }, { x,           2 } }
    periphery[#periphery + 1] = { { x, field_y - 2 }, { x, field_y - 1 } }
  end
  for y = 5, field_y - 4, 2 do
    periphery[#periphery + 1] = { { 3,           y }, { 2,           y } }
    periphery[#periphery + 1] = { { field_x - 2, y }, { field_x - 1, y } }
  end

  local exit = periphery[math.floor(torch.uniform(1, #periphery + 1))]
  field[exit[1]] = 1
  field[exit[2]] = 0

  return rearrange(field, size_x, size_y)
end

function rearrange(raw_field, size_x, size_y)
  --[[
  each cell in the field containes 5-element array (all elemtns are binary).
  first 4 bits indicate if there are wall around the cell (1 means wall).
  last bit indicate if the cell is the exit (1 means exit).
  i.e. { wall_1, wall_2, wall_3, wall_4, exit }
  --]]
  local field = torch.ShortTensor(size_x, size_y, 5):zero()

  for x = 1, size_x do
    for y = 1, size_y do
      local current_cell = { x * 2 + 1, y * 2 + 1 }
      local neighbor = {
        { current_cell[1] - 1, current_cell[2]     },
        { current_cell[1],     current_cell[2] + 1 },
        { current_cell[1] + 1, current_cell[2]     },
        { current_cell[1],     current_cell[2] - 1 },
      }
      for direction = 1, 4 do
        if raw_field[neighbor[direction]] == 9 then
          field[x][y][direction] = 1
        end
      end
      if raw_field[current_cell] == 1 then
        field[x][y][5] = 1
      end
    end
  end

  return field
end
