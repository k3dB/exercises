function! Raindrops(number) abort
  let l:replacements = {
    \ "3": "Pling",
    \ "5": "Plang",
    \ "7": "Plong"
  \ }

  let l:result = ""

  for key in keys(l:replacements)
    if a:number % str2nr(key) == 0
      let l:result .= l:replacements[key]
    endif
  endfor

  return strlen(l:result) ? l:result : "" . a:number
endfunction
