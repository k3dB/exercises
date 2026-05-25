section .text
global square_of_sum
square_of_sum:
    ; Sum of natural numbers: n * (n + 1) / 2
    ; This function returns the square of this sum
    mov   rax, rdi        ; n => rax for multiplication
    inc   rdi             ; n + 1
    mul   rdi             ; n * (n + 1) => rax
    shr   rax, 1          ; n * (n + 1) / 2
    mul   rax             ; Square the sum
    ret

global sum_of_squares
sum_of_squares:
    ; Sum of square of natural numbers: n * (n + 1) * (2 * n + 1) / 6
    mov   rax, rdi        ; n => rax for multiplication
    mov   rdx, rdi        ; n => rdx for n + 1 (rdi preserved for 2 * n + 1)
    inc   rdx             ; n + 1
    mul   rdx             ; n * (n + 1) => rax
    shl   rdi, 1          ; 2 * n
    inc   rdi             ; 2 * n + 1
    mul   rdi             ; n * (n + 1) * (2 * n + 1) => rax
    xor   rdx, rdx        ; Prepare division
    mov   rcx, 6
    div   rcx             ; n * (n + 1) * (2 * n + 1) / 6 => rax
    ret

global difference_of_squares
difference_of_squares:
    ; Square of sum minus the sum of squares
    push  rbx             ; Prologue
    mov   rbx, rdi        ; Preserve input value
    call  sum_of_squares
    mov   rdi, rbx        ; Restore input for next call
    mov   rbx, rax        ; Preserve result of first call
    call  square_of_sum
    sub   rax, rbx        ; Difference
    pop   rbx             ; Epilogue
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
