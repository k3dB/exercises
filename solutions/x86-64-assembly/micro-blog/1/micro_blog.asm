section .text
global truncate

; void truncate(char *buffer, const char *phrase)
truncate:
    xor   rcx, rcx        ; Count codepoints
    mov   rdx, 1          ; Encoding byte count

.next_byte:
    mov   al, byte[rsi]   ; Get current byte
    movsb                 ; Copy byte to buffer
    dec   rdx             ; Decrement codepoint byte count
    jnz   .next_byte      ; If ZF not set, copy next byte

    mov   r8b, al         ; Copy current byte
    and   r8b, 0xF0       ; Check UTF-8 encoding for more codepoint bytes
    cmp   r8b, 0xF0       ; 4-byte codepoint?
    je    .four_bytes

    cmp   r8b, 0xE0       ; 3-byte codepoint?
    jae   .three_bytes

    cmp   r8b, 0xC0       ; 2-byte codepoint?
    jae   .two_bytes

    test  al, al          ; Reached end of input?
    jz    .done           ; If so, we are done

    inc   rcx             ; Count codepoint
    cmp   rcx, 5          ; Reached limit?
    je    .done

    mov   rdx, 1          ; Prepare for next codepoint
    jmp   .next_byte

.two_bytes:
    mov   rdx, 1          ; 1 more byte (first byte is already copied)
    jmp   .next_byte

.three_bytes:
    mov   rdx, 2          ; 2 more bytes (first byte is already copied)
    jmp   .next_byte

.four_bytes:
    mov   rdx, 3          ; 3 more bytes (first byte is already copied)
    jmp   .next_byte

.done:
    mov   byte [rdi], 0   ; Make sure output is null-terminated
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
