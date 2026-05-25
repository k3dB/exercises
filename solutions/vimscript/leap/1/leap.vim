function! LeapYear(year) abort
  let l:divisibleBy4   = a:year %   4 == 0
  let l:divisibleBy100 = a:year % 100 == 0
  let l:divisibleBy400 = a:year % 400 == 0
  return divisibleBy4 && !divisibleBy100 || divisibleBy400
endfunction
