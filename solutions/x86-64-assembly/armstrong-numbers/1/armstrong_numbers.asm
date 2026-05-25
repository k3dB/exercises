section .text
global is_armstrong_number
is_armstrong_number:
    push  rbp      ; Preserve base pointer
    mov   rbp, rsp ; Preserve current stack pointer in base pointer

    mov   r8,  rdi ; Copy input
    mov   r10, 10  ; Working with decimal (base 10) numbers
    xor   ecx, ecx ; Count digits for exponent
    xor   esi, esi ; Sum each digit to the power of digit count

_count:
    inc   ecx      ; Increment digit count (exponent)
    xor   edx, edx ; Clear higher bits for division
    mov   rax, r8  ; Current set of input digits to count
    div   r10      ; Shift right (logical) decimal input value
    push  rdx      ; Put current digit (remainder) on the stack
    mov   r8, rax  ; Store quotient as next dividend (number to shift)
    test  r8, r8   ; Have we counted and stored all the input digits?
    jnz   _count

_next:
    pop   r11      ; Get next digit from stack
    mov   r8, 1    ; Initialize accumulator for exponentiation
    mov   r9, rcx  ; Reset volatile copy of exponent (digit count)

__pow: ; Expontentiation by squaring
    test  r9, 1    ; Is the current exponent odd?
    jz    __square ; If even, we can square the digit
    mov   rax, r11 ; Setup multiplication
    mul   r8       ; Accumulate powers of digit
    mov   r8, rax  ; Move result to accumulator

__square:
    mov   rax, r11 ; Setup multiplication
    mul   r11      ; Square digit
    mov   r11, rax
    shr   r9, 1    ; Halve exponent (also shifts out 1s from odd cases)
    test  r9, r9   ; Have we reached zero for the exponent?
    jnz   __pow

    add   rsi, r8  ; Keep sum of each digit to the power of digit count
    cmp   rbp, rsp ; Are there more digits left on the stack?
    jnz   _next

    xor   rax, rax ; Assume false
    mov   rdx, 1   ; Set up possible true
    cmp   rdi, rsi ; Compare sum with original input
    cmove rax, rdx ; Return true if equal

    mov   rsp, rbp ; Restore stack pointer
    pop   rbp      ; Restore base pointer
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
