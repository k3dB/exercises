return function(n)
  return coroutine.create(
    function()
      local candidates = {}

      for i = 2, n do
        candidates[i] = true
      end

      for i = 2, n do
        if candidates[i] then
          for j = i^2, n, i do
            candidates[j] = false
          end

          coroutine.yield(i)
        end
      end
    end
  )
end
