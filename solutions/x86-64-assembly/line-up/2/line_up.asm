default rel

section .rodata

st db "st"
nd db "nd"
rd db "rd"
th db "th"

intro db ", you are the "
intro_size equ $ - intro

outro db " customer we serve today. Thank you!", 0
outro_size equ $ - outro

section .text
global format

; void format(char *buffer, const char *name, uint16_t number)
format:
    ; This function takes a buffer, a name, and a number and stores a string in
    ; the buffer with the folowing format:
    ; "%s, you are the %u%s customer we serve today. Thank you!",
    ; name, number, ordinal suffix
    push  rbp                 ; Prologue
    mov   rbp, rsp
    sub   rsp, 24             ; Reserve room for up to 3 pushes (1 per digit)

.next_name:
    mov   al, byte [rsi]      ; Get current name byte
    movsb                     ; Copy name byte to buffer
    test  al, al              ; Check if we are done copying the name
    jnz   .next_name          ; If not, continue with next name byte
    dec   rdi                 ; Backup buffer position to the NUL byte
    mov   byte [rdi], ' '     ; Replace the NUL with a space
    lea   rsi, [intro]

    mov   rcx, intro_size     ; Get length of intro
    rep   movsb               ; Copy intro

    mov   ax, dx              ; Copy number
    xor   ecx, ecx            ; Count digits

.next_digit:
    inc   ecx                 ; Count digits
    xor   edx, edx            ; Clear for division
    mov   r8w, 10             ; Get current digit
    div   r8w
    push  dx                  ; Store digit (remainder) on stack (right to left)
    test  ax, ax              ; Check if there are more digits
    jnz   .next_digit

    cmp   ecx, 1              ; Check if there is only one digit
    sete  r9b                 ; If so, set flag

.unwind_digits:
    pop   dx                  ; Pop each digit off the stack (left to right)
    add   dl, '0'             ; Convert digit to ASCII
    mov   byte [rdi], dl      ; Store digit in buffer
    inc   rdi                 ; Advance buffer position
    cmp   ecx, 2              ; Is this the second to last digit?
    jnz   .skip_tens_check    ; If not skip tens place check
    cmp   dl, '1'             ; Is the tens place digit a one?
    sete  r8b                 ; If so, set flag
.skip_tens_check:
    dec   ecx                 ; Rewind count of digits
    test  ecx, ecx            ; Any more digits?
    jnz   .unwind_digits

    test  r8b, r8b            ; If a one is not in the tens place,
    je    .compare_special    ; check for special case

    cmp   r9b, 1              ; If there is only one digit,
    je    .compare_special    ; check for special case

    jmp   .load_th            ; Otherwise, there is no a special case

.compare_special:
    cmp   dl, '1'             ; Check for possible special case
    je    .load_st
    cmp   dl, '2'
    je    .load_nd
    cmp   dl, '3'
    je    .load_rd
    jmp   .load_th            ; If not a special case, use "th"

.load_st:
    lea   rsi, [st]
    jmp   .append_suffix
.load_nd:
    lea   rsi, [nd]
    jmp   .append_suffix
.load_rd:
    lea   rsi, [rd]
    jmp   .append_suffix
.load_th:
    lea   rsi, [th]
    jmp   .append_suffix

.append_suffix:
    movsw                     ; Copy suffix
    lea   rsi, [outro]        ; Prepare to load outro

    mov   rcx, outro_size     ; Get length of outro
    rep   movsb               ; Copy outro

    mov   rsp, rbp            ; Epilogue
    pop   rbp
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
