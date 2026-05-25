default rel

section .data

suffix db ", please.", 0
suffix_length dd $ - suffix

section .text

global front_door_response
global front_door_password
global back_door_response
global back_door_password

front_door_response:
    ; This function takes the address in memory for a line of the poem as an
    ; argument.
    ; It returns the first letter of that line, as a ASCII-encoded character.
    mov al, byte [rdi]
    ret

front_door_password:
    ; This function takes as argument the address in memory for a string
    ; containing the combined letters you found in task 1.
    ; It modifies this string in-place, making it correctly capitalized.
    ; The function has no return value.
    mov   rsi, rdi        ; Copy address to RSI
    lodsb                 ; Load first byte into AL
    and   al, 0xDF        ; Capitalize first letter
    stosb                 ; Update byte in-place

.next_letter:
    lodsb                 ; Get next letter
    test  al, al          ; Have we reached the end of the word?
    jz    .done           ; If so, we are done
    or    al, 32          ; Otherwise, convert to lower case
    stosb                 ; In-place update
    jmp   .next_letter

.done:
    ret

back_door_response:
    ; This function takes as argument the address in memory for a line of the
    ; poem. It returns the last letter of that line that is not a whitespace
    ; character, as a ASCII-encoded character.
    mov    rsi, rdi       ; Copy address to RSI

.next_byte:
    lodsb                 ; Load next byte into AL
    test   al, al         ; Have we reached the end of the word?
    jz     .done          ; If so, we are done
    mov    cl, al         ; Copy byte
    or     cl, 32         ; Convert copy to lower case
    sub    cl, 'a'        ; Convert to index
    cmp    cl, 'z'        ; Check if it is a letter
    cmovbe dx, ax         ; If so, use DL to store it as a potential result
    jmp    .next_byte

.done:
    mov    al, dl         ; Return last letter found
    ret

back_door_password:
    ; This function takes as arguments, in this order:
    ; 1. The address in memory for a buffer where the resulting string will be
    ;    stored.
    ; 2. The address in memory for a string containing the combined letters you
    ;    found in task 3.
    ; It stores the polite version of the capitalized password in the buffer.
    ; A polite version is correctly capitalized and has ", please." added at
    ; the end. The function has no return value.
    lodsb                 ; Load first byte into AL
    and   al, 0xDF        ; Capitalize first letter
    stosb                 ; Store byte in buffer

.next_letter:
    lodsb                 ; Get next letter
    test  al, al          ; Reached the end of the word?
    jz    .copy_suffix    ; If so, we are done
    or    al, 32          ; Otherwise, convert to lower case
    stosb                 ; Store byte in buffer
    jmp   .next_letter

.copy_suffix:
    lea rsi, [suffix]
    mov ecx, dword [suffix_length]
    rep movsb

    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
