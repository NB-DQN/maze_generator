function generate_field(size_x, size_y)
  local field_x = size_x * 2 + 3
  local field_y = size_y * 2 + 3

  local field = torch.Tensor(field_x, field_y):zero()
  field[{ { 2, field_x - 1 }, { 2, field_y - 1 } }] = 1

  local start_cell = { math.floor(torch.uniform(1, size_x)) * 2 + 1, math.floor(torch.uniform(1, size_y)) * 2 + 1 }
  field[start_cell] = 0
  local active_cells = { start_cell }

  while #active_cells > 0 do
    local current_cell = active_cells[#active_cells]
    local next_cell

    local candidate_cells = {
      { current_cell[1] - 2, current_cell[2]     },
      { current_cell[1],     current_cell[2] + 2 },
      { current_cell[1] + 2, current_cell[2]     },
      { current_cell[1],     current_cell[2] - 2 },
    }
    local path = {
      { current_cell[1] - 1, current_cell[2]     },
      { current_cell[1],     current_cell[2] + 1 },
      { current_cell[1] + 1, current_cell[2]     },
      { current_cell[1],     current_cell[2] - 1 },
    }
    local candidates = {}
    for direction = 1, 4 do
      if field[candidate_cells[direction]] == 1 then
        candidates[#candidates + 1] = direction
      end
    end

    if #candidates > 0 then
      local direction = candidates[math.floor(torch.uniform(1, #candidates + 1))]
      local next_cell = candidate_cells[direction]
      field[next_cell] = 0
      active_cells[#active_cells + 1] = next_cell
      field[path[direction]] = 0
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
  field[exit[1]] = 9
  field[exit[2]] = 0

  return field
end
