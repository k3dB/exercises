default rel

section .data

black:  db "black",  0
brown:  db "brown",  0
red:    db "red",    0
orange: db "orange", 0
yellow: db "yellow", 0
green:  db "green",  0
blue:   db "blue",   0
violet: db "violet", 0
grey:   db "grey",   0
white:  db "white",  0

align 8
resistor_colors:
    dq black
    dq brown
    dq red
    dq orange
    dq yellow
    dq green
    dq blue
    dq violet
    dq grey
    dq white
    dq 0                    ; Mark end of resistor_colors

section .text

global value

; int value(const char *first, const char *second, const char *third)
value:
    ; This function takes the first two resistor colors and returns the two
    ; digit value. The third parameter is ignored.
    ; Note that the color_code function does not use RSI or R10 (and is a leaf
    ; function), so we do not have to preserve anything on the stack.
    call  color_code        ; Get tens place
    mov   r10, rax          ; Save in an unused register
    mov   rdi, rsi          ; Get ones place
    call  color_code
    imul  r10, 10           ; Move tens place value to tens place
    add   rax, r10          ; Add ones place and tens place
    ret

; Local copy from first resistor color exercise.
color_code:
    xor   rax, rax          ; Start with first color and do a linear search
    xor   rcx, rcx          ; Input index

.next_color:
    lea   rdx, [resistor_colors]
    mov   rdx, [rdx + 8 * rax]
    test  rdx, rdx          ; Check if we have exhausted valid inputs
    jz    .invalid

.next_byte:
    mov   r8b, [rdx]        ; Current byte of current color to test
    mov   r9b, [rdi + rcx]  ; Current byte of input color
    test  r8b, r8b          ; Reached end of current color bytes?
    jz    .check_equal
    cmp   r8b, r9b          ; Compare the two bytes
    jne   .not_equal
    inc   rdx               ; Prepare to test next byte
    inc   rcx
    jmp   .next_byte

.check_equal:
    test  r9b, r9b          ; Make sure both strings are the same length
    jz    .done

.not_equal:
    xor   rcx, rcx          ; Reset input index
    inc   rax               ; Move to next color index
    jmp   .next_color

.invalid:
    mov   rax, -1           ; Handle edge case of invalid input
.done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
