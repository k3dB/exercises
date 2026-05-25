function! WordCount(phrase) abort
  let l:word_counts = {}
  let l:words = split(tolower(a:phrase), "[^a-z0-9']")

  for word in l:words
    let l:trimmed_word = trim(word, "'")
    if has_key(l:word_counts, l:trimmed_word)
      let l:word_counts[l:trimmed_word] += 1
    elseif len(l:trimmed_word)
      let l:word_counts[l:trimmed_word] = 1
    endif
  endfor

  return l:word_counts
endfunction
