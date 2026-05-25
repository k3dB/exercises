#!/usr/bin/env bash

pig_latin_phrase=()

for word in "$@";
do
  first_vowel_index=${#word}-1
  first_y_index=-1
  last_consonant="0"
  vowel="0"

  for ((i = 0; i < ${#word}; i++)); do
    char="${word:i:1}"

    if [[ first_y_index -lt 0 && "$char" =~ [yY] ]]; then
      first_y_index=$i
      continue
    fi

    if [[ "$char" =~ [aeiouAEIOU] ]]; then
      first_vowel_index=$i
      vowel=$char
      break
    fi

    last_consonant=$char
  done

  if [[ $first_vowel_index == 0 || ${word::2} == "xr" || ${word::2} == "yt" ]]; then
    pig_latin_phrase+="$1ay "
  else
    if [[ $last_consonant == "q" && $vowel == "u" ]]; then
      ((first_vowel_index++))
    fi

    if [[ $first_y_index > 0 ]]; then
      first_vowel_index=$first_y_index
    fi

    consonants=${word:0:first_vowel_index}
    root=${word#$consonants}$consonants

    pig_latin_phrase+="${root}ay "
  fi
done

printf "${pig_latin_phrase[*]}" | xargs
