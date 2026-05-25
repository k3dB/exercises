function! WordCount(phrase) abort
  let l:word_counts = {}
  let l:words = split(tolower(a:phrase), "[^a-z0-9']")

  for word in l:words
    let l:trimmed_word = TrimQuotes(word)
    if has_key(l:word_counts, l:trimmed_word)
      let l:word_counts[l:trimmed_word] += 1
    elseif len(l:trimmed_word)
      let l:word_counts[l:trimmed_word] = 1
    endif
  endfor

  return l:word_counts
endfunction

function! TrimQuotes(word) abort
  let l:single_quote = "'"
  let l:trimmed_word = a:word

  while l:trimmed_word[0] == l:single_quote
    let l:trimmed_word = l:trimmed_word[1 : len(l:trimmed_word) - 1]
  endwhile

  while l:trimmed_word[len(l:trimmed_word) - 1] == l:single_quote
    let l:trimmed_word = l:trimmed_word[0 : len(l:trimmed_word) - 2]
  endwhile

  return l:trimmed_word
endfunction
