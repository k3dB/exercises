section .text
global reverse
reverse:
    lea  r10, [rdi]       ; Address of input (current byte)
    lea  r11, [rdi]       ; Address of input (forward only for swapping)

_count:
    mov  al, [r10]        ; Read next input byte
    cmp  al, 0            ; End of input?
    je   _reverse         ; If so, reverse the input
    inc  r10              ; Otherwise, advance the input byte pointer
    jmp  _count

_reverse:
    dec  r10              ; Previous input byte address
    mov  al, [r10]        ; Current byte
    mov  dl, [r11]        ; Byte to swap with
    mov  [r10], dl        ; Swap byte locations
    mov  [r11], al
    inc  r11              ; Otherwise, advance forward moving pointer
    cmp  r10, r11         ; Did the byte addresses meet or pass each other?
    jg   _reverse         ; If not, continue swapping bytes

_done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
