section .text
global is_isogram
is_isogram:
    xor   eax, eax        ; Default to false (for early exits)
    xor   edx, edx        ; Letter flags (lower 26 bits)

.next_byte:
    mov   cl, [rdi]       ; Get current byte
    test  cl, cl          ; More input bytes?
    jz    .true
    inc   rdi             ; Prepare next byte

    and   cl, 0xDF        ; Convert to upper case
    sub   cl, 'A'         ; Convert to letter index
    cmp   cl, 'Z'         ; Is this byte a letter?
    ja    .next_byte      ; If not, ignore it

    mov   r8d, 1          ; Set a bit mask for letter
    shld  r8d, eax, cl
    test  r8d, edx        ; Has this letter been seen?
    jnz   .false          ; If so, input is not an isogram
    or    edx, r8d        ; Otherwise, set the current letter flag

    jmp   .next_byte

.true:
    or    eax, 1
.false:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
