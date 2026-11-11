default rel

section .bss

remembered resq 1         ; remembered transaction function address
index      resq 1         ; transaction index
count      resq 1         ; transaction count

section .text

global remember_transaction
remember_transaction:
    ; This function takes a function address and stores it in memory
    ;
    ; It has no return value
    mov   qword [remembered], rdi
    ret

global apply_remembered
apply_remembered:
    ; This function takes a 64-bit non-negative integer and applies the previously saved function to it
    ;
    ; It forwards whatever the saved function returns
    jmp   qword [remembered]
    ret

global register_transaction
register_transaction:
    ; It takes as arguments:
    ; 1. the address of a dispatch table
    ; 2. an index, as a 64-bit non-negative integer
    ; 3. a transaction, i.e., a function address
    ; It stores the transaction's address at the given index in the table.
    ;
    ; The function has no return value
    mov   qword [rdi + 8 * rsi], rdx
    ret

global select_transaction
select_transaction:
    ; It takes as arguments:
    ; 1. the address of a dispatch table
    ; 2. an index, as a 64-bit non-negative integer
    ; 3. a starting balance, as a 64-bit non-negative integer
    ; It looks up the transaction at the given index and applies it to the starting balance
    ;
    ; It returns the new balance, calculated by the transaction, as a 64-bit non-negative integer
    mov   rax, rdi                  ; Set up transaction parameter
    mov   rdi, rdx
    jmp   qword [rax + 8 * rsi]     ; Call selected transation
    ret

global process_statement
process_statement:
    ; It takes as arguments:
    ; 1. a starting balance, as a 64-bit non-negative integer
    ; 2. the address of an array of transactions (which are function addresses)
    ; 3. the number of transactions in the array, as a 64-bit non-negative integer
    ;
    ; It composes all functions in the array
    ; That means that, for each transaction in sequence, it should:
    ; 1. apply the transaction to the running balance
    ; 2. then use the result as the balance for the next transaction
    ;
    ; The final balance is returned, as a 64-bit non-negative integer
    push  rbp                       ; prologue
    mov   rbp, rsp
    sub   rsp, 3 * 8                ; preserve non-volatile registers
    push  rbx                       ; transactions base address
    push  r12                       ; transaction index
    push  r13                       ; transaction count

    mov   rax, rdi                  ; copy balance for empty edge case
    mov   rbx, rsi                  ; transactions base address
    xor   r12, r12                  ; initialize transaction index
    mov   r13, rdx                  ; preserved count

.next_transaction:
    cmp   r12, r13                  ; more transactions?
    je    .done

    lea   rsi, [rbx + 8 * r12]      ; offset of current transaction
    call  [rsi]                     ; apply transaction

    mov   rdi, rax                  ; set up balance parameter for next transaction

    inc   r12                       ; advance to next transaction index
    jmp   .next_transaction

.done:
    pop   r13                       ; epilogue
    pop   r12
    pop   rbx
    mov   rsp, rbp
    pop   rbp
    ret

global process_with_guard
process_with_guard:
    ; It takes as arguments:
    ; 1. a starting balance, as a 64-bit non-negative integer
    ; 2. the address of an array of transaction (which are function addresses)
    ; 3. the number of transactions in the array, as a 64-bit non-negative integer
    ; 4. the memory address of a guard function.
    ;
    ; For each transaction in sequence, this function:
    ; 1. Apply the transaction to the running balance to compute a tentative new balance
    ; 2. Call the guard with the tentative balance
    ; 3. If the guard returns non-zero, the running balance becomes the tentative balance
    ; 4. If the guard returns zero, the running balance is unchanged and the transaction is skipped
    ;
    ; The function returns two values, respectively:
    ; 1. the final balance, after all updates (if any)
    ; 2. the number of approved transactions (those for which the guard function returns non-zero)
    push   rbp                      ; prologue
    mov    rbp, rsp
    sub    rsp, 5 * 8               ; preserve non-volatile registers
    push   rbx                      ; transactions base address
    push   r12                      ; balance
    push   r13                      ; tentative balance
    push   r14                      ; approved count
    push   r15                      ; guard function address

    xor    r14, r14                 ; clear approved count
    mov    r15, rcx                 ; preserve guard function
    mov    r12, rdi                 ; copy balance for empty edge case
    mov    rbx, rsi                 ; transactions base address
    xor    rcx, rcx                 ; transaction index
    mov    qword [index], rcx       ; store index and count in memory
    mov    qword [count], rdx

.next_transaction:
    mov    rcx, qword [index]       ; get current index value
    cmp    rcx, qword [count]       ; more transactions?
    je     .done

    lea    rsi, [rbx + 8 * rcx]     ; offset of current transaction
    call   [rsi]                    ; apply transaction
    mov    r13, rax                 ; preserve new tentative balance

    mov    rdi, rax                 ; set up guard check with new tentative balance
    call   r15                      ; call guard function

    test   rax, rax                 ; check return value of guard function
    cmovz  rdi, r12                 ; use old balance if guard did not pass
    cmovnz rdi, r13                 ; otherwise, use new tentative balance
    setnz  cl                       ; conditionally update approved transaction count
    add    r14b, cl                 ; assumes less than 256 approved transactions
    mov    r12, rdi                 ; update balance

    inc    qword [index]            ; advance to next transaction
    jmp    .next_transaction

.done:
    mov    rax, r12                 ; final balance
    mov    rdx, r14                 ; approved count

    pop    r15                      ; epilogue
    pop    r14
    pop    r13
    pop    r12
    pop    rbx
    mov    rsp, rbp
    pop    rbp
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
