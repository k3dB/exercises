section .rodata

; Index offsets
adenine  equ  0
cytosine equ  8
guanine  equ 16
thymine  equ 24

section .text

%macro check_nucleotide 2
    cmp   dl, %1          ; Current input byte matches given nucleotide?
    jne   %%check_next    ; If not, continue to next nucleotide
    inc   %2              ; Otherwise, increment count and...
    jmp   .next_byte      ; ...continue to next input byte
%%check_next:
%endmacro

global nucleotide_counts
nucleotide_counts:
    ; Initialize counts to zero
    xor   r8, r8          ; Adenine counter
    xor   r9, r9          ; Cytosine counter
    xor   r10, r10        ; Guanine counter
    xor   r11, r11        ; Thymine counter

.next_byte:
    mov   dl, [rdi]       ; Get next byte
    test  dl, dl          ; Finished parsing input?
    jz    .done
    inc   rdi             ; Prepare next byte

    check_nucleotide 'A', r8
    check_nucleotide 'C', r9
    check_nucleotide 'G', r10
    check_nucleotide 'T', r11

.invalid:
    mov   r8, -1
    mov   r9, -1
    mov   r10, -1
    mov   r11, -1

.done:
    mov   [rsi +  adenine], r8  ; Load counts into array
    mov   [rsi + cytosine], r9
    mov   [rsi +  guanine], r10
    mov   [rsi +  thymine], r11
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
