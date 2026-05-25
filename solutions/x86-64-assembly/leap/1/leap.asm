section .text
global leap_year

leap_year:
    mov  r8, 400         ; Years divisible by 400...
    call is_divisible    ; (checking divisibility)
    je   true            ; ...are leap years

    test rdi, 11b        ; Years not divisible by 4...
    jnz  false           ; ...are not leap years

    mov  r8, 100         ; Years divisible by 100...
    call is_divisible    ; (already checked the exception of 400)
    je   false           ; ...are not leap years

is_divisible:
    mov rax, rdi         ; Check divisibility of input with register R8
    xor rdx, rdx         ; Clear RDX for division
    div r8
    cmp rdx, 0           ; Check if there is a remainder
    ret

true:
    mov rax, 1
    ret

false:
    xor rax, rax
    ret
