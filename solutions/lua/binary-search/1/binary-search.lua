return function(array, target)
  local lower_bound = 1
  local upper_bound = #array

  while (lower_bound <= upper_bound) do
    local middle_index = math.floor(lower_bound / 2 + upper_bound / 2)
    local middle_item  = array[middle_index]

    if (middle_item == target) then return middle_index end

    if (middle_item < target) then
      lower_bound = middle_index + 1
    else
      upper_bound = middle_index - 1
    end
  end

  return -1
end
