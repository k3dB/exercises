section .text
global truncate

; void truncate(char *buffer, const char *phrase)
truncate:
    xor   rcx, rcx        ; Count codepoints

.next_codepoint:
    mov   al, byte[rsi]   ; Get current byte
    test  al, al          ; Reached end of input?
    jz    .done           ; If so, we are done

    movsb                 ; Copy byte to buffer

    and   al, 0xF0        ; Check UTF-8 encoding for more codepoint bytes
    cmp   al, 0xF0        ; 4-byte codepoint?
    je    .four_bytes

    cmp   al, 0xE0        ; 3-byte codepoint?
    jae   .three_bytes

    cmp   al, 0xC0        ; 2-byte codepoint?
    jae   .two_bytes
    jmp   .one_byte


.four_bytes:
    movsb                 ; 3 more bytes

.three_bytes:
    movsb                 ; 2 more bytes

.two_bytes:
    movsb                 ; 1 more byte

.one_byte:
    inc   rcx             ; Count codepoint
    cmp   rcx, 5          ; Reached limit?
    jb    .next_codepoint



.done:
    mov   byte [rdi], 0   ; Make sure output is null-terminated
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
