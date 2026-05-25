default rel

section .bss

letter_counts resb 26

section .text
global find_anagrams

; void find_anagrams(
;     int        *is_anagram,
;     const char *candidates[],
;     size_t     num_candidates,
;     const char *subject)
find_anagrams:
    push r12                   ; Preserve callee saved register
    lea  r12, letter_counts    ; Base letter_counts address

.next_candidate:
    dec  rdx                   ; Use count as index and check in reverse order
    jl   .done                 ; If index goes negative, we are done
    mov  r8, qword [rsi + 8 * rdx] ; Address of current candidate
    xor  r9, r9                ; Reset subject index
    xor  rax, rax              ; Set to one if possible anagram (not same word)

    mov  qword [r12 +  0], 0   ; Clears letter_counts indexes 0 - 7
    mov  qword [r12 +  8], 0   ; Clears letter_counts indexes 8 - 15
    mov  qword [r12 + 16], 0   ; Clears letter_counts indexes 15 - 23
    mov   word [r12 + 24], 0   ; Clears letter_counts indexes 24 and 25

.next_subject_letter:
    movzx r10, byte [rcx + r9] ; Get current subject letter
    test  r10, r10             ; More subject letters?
    jz    .check_anagram
    movzx r11, byte [r8 + r9]  ; Get current candidate letter
    test  r11, r11             ; More candidate letters?
    jz    .next_candidate

    inc  r9                    ; Prepare for next subject letter

    ; Assumes only ASCII English letters in subject and candidates.
    or   r10b, 32              ; Convert both to lowercase
    or   r11b, 32
    sub  r10b, 'a'             ; Convert both to letter_counts index
    sub  r11b, 'a'

    cmp  r10b, r11b            ; Are the letters the same?
    je   .next_subject_letter  ; If so, move on to the next letter
    mov  rax, 1                ; Otherwise, not the same word

    inc  [r12 + r10]           ; Add count for current subject letter
    dec  [r12 + r11]           ; Remove one count from current candidate letter
    jmp  .next_subject_letter

.check_anagram:
    test  rax, rax             ; Is current candidate same word as subject?
    jz    .next_candidate
    movzx r11, byte [r8 + r9]  ; Get current candidate letter
    test  r11, r11             ; Is current candidate same length as subject?
    jnz   .next_candidate

    mov  rax, qword [r12 +  0] ; Checkes letter_counts indexes 0 - 7
    test rax, rax              ; If not zero, check next candidate
    jnz  .next_candidate
    mov  rax, qword [r12 +  8] ; Checkes letter_counts indexes 8 - 15
    test rax, rax              ; If not zero, check next candidate
    jnz  .next_candidate
    mov  rax, qword [r12 + 16] ; Checkes letter_counts indexes 15 - 23
    test rax, rax              ; If not zero, check next candidate
    jnz  .next_candidate
    mov  ax,   word [r12 + 24] ; Checkes letter_counts indexes 24 and 25
    test ax, ax                ; If not zero, check next candidate
    jnz  .next_candidate

    mov  dword [rdi + 4 * rdx], 1 ; Set anagram flag for current candidate
    jmp  .next_candidate

.done:
    pop  r12                   ; Restore callee saved register
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
