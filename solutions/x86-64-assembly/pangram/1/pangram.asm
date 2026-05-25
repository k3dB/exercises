default rel

section .data
letter_counts db 26 dup(0)

section .text
global is_pangram
is_pangram:
    lea   rdx, [letter_counts]
    xor   rax, rax
    mov   qword [rdx +  0], rax ; Clear first 24 bytes 8 at a time
    mov   qword [rdx +  8], rax
    mov   qword [rdx + 16], rax
    mov   word  [rdx + 24],  ax ; Clear last 2 bytes

    lea   rdx, [rdi]            ; Load address of input

.next_count:
    mov   al, [rdx]             ; Get current input byte
    inc   rdx                   ; Prepare for next input byte
    test  al, al                ; Finished reading input?
    jz    .check_counts
    and   rax, 0xDF             ; Convert to upper case letter
    cmp   rax, 'A'              ; Skip non-letter bytes
    jb    .next_count
    cmp   rax, 'Z'
    ja    .next_count
    sub   rax, 'A'              ; Convert to index
    lea   r8, [letter_counts]
    inc   byte [r8 + rax]       ; Increment count of letter at index
    jmp   .next_count

.check_counts:
    mov   rcx, 26
    lea   rdx, [letter_counts]
    xor   eax, eax              ; Assume false

.check_next_count:
    dec   rcx
    test  rcx, rcx              ; Finished checking counts?
    jz    .true                 ; We verified all counts to be non-zero
    mov   r8b, [rdx]            ; Get next count
    test  r8b, r8b              ; If any count is zero,
    jz    .false                ; return false
    inc   rdx                   ; Otherwise, move to next count to check
    jmp   .check_next_count

.true:
    or    eax, 1                ; Set to true
.false:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
