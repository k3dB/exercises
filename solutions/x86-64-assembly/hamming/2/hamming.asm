section .text
global distance
distance:
    xor    eax, eax       ; Clear output count
    lea    r8, [rdi]      ; Read address of each input
    lea    r9, [rsi]

_next:
    mov    cl, [r8]       ; Next nucleotide of first input
    mov    dl, [r9]       ; Next nucleotide of other input
    cmp    cl, 0          ; Have we reached the end of the first input?
    je     _check_other   ; If so, check that we also finished other input
    cmp    dl, 0          ; Have we reached the end of the second input?
    je     _invalid       ; If so, second input is shorter than the first

    cmp    cl, dl         ; Compare the current nucleotide bytes
    setne  dl             ; Set RDX to 1 if not equal (otherwise cleared)
    add    rax, rdx       ; Add the one (or zero) to output count

    inc    r8             ; Prepare next bytes to compare
    inc    r9
    jmp    _next

_check_other:
    cmp    dl, 0          ; Did we reach the end of both at the same time?
    jne    _invalid       ; If not, then it is invalid
    ret                   ; Otherwise, we return the valid count

_invalid:
    mov    eax, -1        ; Output is a 32 bit signed integer
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
