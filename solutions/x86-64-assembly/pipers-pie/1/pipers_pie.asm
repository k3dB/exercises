section .text

global largest_portion
global double_factorial
global pipers_pi

; This function is already pre-defined and matches the example in the concept
factorial:
    ; This function takes a 64-bit non-negative integer as argument.
    ; It computes the factorial of this argument
    ; and returns it as a 64-bit non-negative integer.
    mov   rax, 1
factorial_helper:
    cmp   rdi, 1
    jle   .base_case

    imul  rax, rdi
    dec   rdi
    jmp   factorial_helper
.base_case:
    ret

; uint64_t largest_portion(uint64_t a, uint64_t b)
largest_portion:
    ; This function takes two 64-bit non-negative integers as arguments.
    ; It calculates the greatest common divisor (gcd) of both numbers
    ; and returns it as a 64-bit non-negative integer.
    mov   rax, rdi
    cmp   rdi, rsi
    je    .found_gcd        ; If they are the same number, return the number
    ja    .next_gcd         ; Make sure first argument is largest
    xchg  rdi, rsi          ; If not, swap them

.next_gcd:
    mov   rax, rdi
    test  rsi, rsi          ; Check for base case (second argument is zero)
    jz    .found_gcd

    mov   rdi, rsi          ; Secong argument becomes first of next case
    xor   rdx, rdx          ; Clear rdx for div
    div   rsi
    mov   rsi, rdx          ; Remainder becomes second argument of next case
    jmp   .next_gcd

.found_gcd:
    ret

; uint64_t double_factorial(uint32_t n)
double_factorial:
    ; This function takes one 32-bit non-negative integer as argument.
    ; It calculates its double factorial
    ; and returns it as a 64-bit non-negative integer.
    ;
    ; The double factorial (!!) is defined as:
    ;
    ; 0!! = 1
    ; n!! = 1 * 3 * 5 * ... * n if n is odd
    ; n!! = 2 * 4 * 6 * ... * n if n is even
    mov   rax, 1
.next_double_factorial:
    cmp   rdi, 1
    jle   .base_case

    imul  rax, rdi
    sub   rdi, 2          ; Only difference from factorial is decrementing by 2
    jmp   .next_double_factorial
.base_case:
    ret

; double pipers_pi(uint32_t n)
pipers_pi:
    ; This function takes a 32-bit non-negative integer as argument.
    ; It calculates an approximation of π using the Newton/Euler Convergence
    ; Transformation and returns it as a 64-bit floating-point number.
    ;
    ; The Newton/Euler Convergence Transformation is defined as a sum:
    ;
    ; π / 2 = sum for k from 0 to infinity of ( k! ) / ( 2 * k + 1 )!!
    ; (where ! designates the factorial and !!, the double factorial)
    ;
    ; Your approximation should sum n + 1 terms, where n is the argument.
    ; This means the argument is the upper limit of the sum.
    ;
    ; This uses scratch registers not used by the called functions instead of
    ; using the stack to preserve values since there are enough to do so.
    xor      rcx, rcx         ; The value of k for each iteration
    mov      r10, rdi         ; Preserve input in unused scratch register
    pxor     xmm0, xmm0       ; Start with zero sum

.next_sum:
    mov      rdi, rcx         ; Current value of k
    call     factorial
    mov      r8, rax          ; Preserve numerator in an unused scratch register
    mov      rdi, rcx         ; Current value of k
    shl      rdi, 1           ; 2 * k
    inc      rdi              ; 2 * k + 1
    call     double_factorial ; Denominator in rax
    cvtsi2sd xmm1, r8         ; Convert numerator to double
    cvtsi2sd xmm2, rax        ; Convert denominator to double
    divsd    xmm1, xmm2       ; Current value to tally in the total
    addsd    xmm0, xmm1       ; Accumulate total
    inc      rcx              ; Increment k
    cmp      rcx, r10         ; More iterations?
    jle      .next_sum

    addsd    xmm0, xmm0       ; Double final result to get π
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
