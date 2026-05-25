function! Distance(strand1, strand2)
  if strlen(a:strand1) != strlen(a:strand2)
    throw 'left and right strands must be of equal length'
  endif

  let l:index = 0
  let l:count = 0

  while l:index < strlen(a:strand1)
    if (a:strand1[index] != a:strand2[index])
      let l:count += 1
    endif

    let l:index += 1
  endwhile

  return l:count
endfunction
