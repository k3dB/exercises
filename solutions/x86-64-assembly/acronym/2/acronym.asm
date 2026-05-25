BUFFER_SIZE equ 0x100

section .text
global abbreviate

; void abbreviate(const char *in, char *out)
abbreviate:
    xor  rcx, rcx         ; Count bytes to make sure we do not go past buffer
    mov  r11, 1           ; Flag to include in acronym; starts with first letter

.next_byte:
    inc  rcx              ; Count current byte
    cmp  rcx, BUFFER_SIZE ; Do not read/write beyond buffer size
    je   .return

    mov  al, byte [rdi]   ; Get current byte
    test al, al           ; First check if we reached the end of input
    jz   .return
    inc  rdi              ; Prepare for next input byte

    cmp  al, ' '          ; Check if we reached a delimiter
    je   .delimiter
    cmp  al, '-'          ; Dashes are also delimiters
    je   .delimiter

    test r11, r11         ; If flag is not set, move to next byte
    jz   .next_byte

    and  al, 0xDF         ; Capitalize (if letter)
    cmp  al, 'A'          ; Verify that we have a letter
    jb   .next_byte       ; If not a letter, skip
    cmp  al, 'Z'
    ja   .next_byte       ; If not a letter, skip
    mov  byte [rsi], al   ; Otherwise, add to acronym
    inc  rsi              ; Prepare for next output byte
    xor  r11, r11         ; Clear include flag
    jmp  .next_byte

.delimiter:
    mov  r11, 1           ; Reset flag to include next letter in acronym
    jmp  .next_byte

.return:
    mov  byte [rsi], 0    ; Null-ternminate output
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
