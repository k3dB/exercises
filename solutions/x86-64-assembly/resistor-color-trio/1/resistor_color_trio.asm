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
    dq 0                  ; Mark end of resistor_colors

giga db "giga"
mega db "mega"
kilo db "kilo"
ohms db "ohms"

section .text
global label

; void label(char *buffer, const char **colors)
label:
    push rbp              ; Prologue
    mov  rbp, rsp
    sub  rsp, 24          ; Preserve room for 3 64-bit registers
    push rdi              ; Keep original buffer location first on stack

    ; Not preserving RSI on stack because it is not changed by color_code.

    mov  rdi, [rsi]       ; Address of first color
    call color_code       ; Get tens place value
    cmp  rax, -1          ; Check for invalid color input
    je   .invalid
    push rax              ; Preserve tens place value on stack

    mov  rdi, [rsi + 8]   ; Address of second color
    call color_code       ; Get second color code
    pop  rdx              ; Release from stack in case of invalid data
    cmp  rax, -1          ; Check for invalid color input
    je   .invalid
    push rdx              ; Re-push tens place value
    push rax              ; Preserve ones place value

    mov  rdi, [rsi + 16]  ; Address of third color
    call color_code       ; Get last color code
    pop  rdx              ; Restore ones place value
    pop  rcx              ; Restore tens place value
    cmp  rax, -1          ; Check for invalid color input
    je   .invalid
    pop  rdi              ; Restore output buffer address
    mov  r9, rdi          ; Preserve beginning of output buffer

    mov  r8, rax          ; Preserve exponent to determine how many 0s to append
    inc  rax              ; Add ones place to count total number of ohm digits
    test rcx, rcx         ; Check if there is a tens place value
    jz   .ones            ; If not, skip to handling ones place
    inc  rax              ; Otherwise, count tens place
    add  cl, '0'          ; Convert tens place value to ASCII digit
    mov  byte [rdi], cl   ; Write to buffer
    inc  rdi              ; Advance output buffer pointer to next byte

    test rdx, rdx         ; Check if ones place is zero
    jz   .space           ; If so, do not use a decimal point or ones place
    cmp  al, 4            ; Check if a decimal point is needed
    je   .decimal
    cmp  al, 7
    je   .decimal
    cmp  al, 10
    jne  .ones

.decimal:
    mov  byte [rdi], '.'  ; Write decimal point to output buffer
    inc  rdi              ; Advance output buffer pointer to next byte
    xor  r8, r8           ; Do not append zeros when using a decimal

.ones:
    add  dl, '0'          ; Convert ones place value to ASCII digit
    mov  byte [rdi], dl   ; Write ones place to output buffer
    inc  rdi              ; Advance output buffer pointer to next byte
    test r8, r8           ; Skip zero appending if a decimal point is present
    jz   .space

    cmp  r8, 8            ; Check if two zeros need to be appended
    je   .append_two_zeros
    cmp  r8, 5
    je   .append_two_zeros
    cmp  r8, 2
    je   .append_two_zeros

    cmp  r8, 7            ; Check if one zero needs to be appended
    je   .append_one_zero
    cmp  r8, 4
    je   .append_one_zero
    cmp  r8, 1
    je   .append_one_zero
    jmp  .space

.append_two_zeros:
    mov  byte [rdi], '0'
    inc  rdi
.append_one_zero:
    mov  byte [rdi], '0'
    inc  rdi

.space:
    mov  byte [rdi], ' '
    inc  rdi

    cmp  rax, 9           ; Check prefix based on number of digits
    ja   .giga
    cmp  rax, 6
    ja   .mega
    cmp  rax, 3
    ja   .kilo
    jmp  .ohms

.giga:
    lea  rsi, [giga]
    movsd
    jmp  .ohms

.mega:
    lea  rsi, [mega]
    movsd
    jmp  .ohms

.kilo:
    lea  rsi, [kilo]
    movsd

.ohms:
    lea  rsi, [ohms]
    movsd
    dec  rdi              ; Do not include the 's' yet

    mov  dl, byte [r9]    ; Check if we want to keep the 's'
    cmp  dl, '1'
    jne  .plural
    mov  dl, byte [r9 + 1]
    cmp  dl, ' '
    je   .return

.plural:
    inc  rdi              ; Include the 's'

.return:
    mov  byte [rdi], 0    ; Null-terminate output buffer
    mov  rsp, rbp         ; Epilogue
    pop  rbp
    ret

.invalid:
    pop  rdi              ; Restore original buffer address
    mov  byte [rdi], 0    ; Return empty string when input is invalid
    mov  rsp, rbp         ; Epilogue
    pop  rbp
    ret


; Copied from resistor color exercise.
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
    mov   rdx, rcx          ; Return ending offset from input
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
