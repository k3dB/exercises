local bob = {}

function is_silence(phrase)
  return string.match(phrase, "^%s*$")
end

function is_question(phrase)
  return string.match(phrase, "^.*%?%s*$")
end

function is_shouting(phrase)
  return string.match(phrase, "%u") and not string.match(phrase, "%l")
end

function bob.hey(say)
  if is_silence(say) then return "Fine, be that way." end

  if is_question(say) and is_shouting(say) then
    return "Calm down, I know what I'm doing!"
  end

  if is_question(say) then return "Sure" end
  if is_shouting(say) then return "Whoa, chill out!" end

  return "Whatever"
end

return bob
