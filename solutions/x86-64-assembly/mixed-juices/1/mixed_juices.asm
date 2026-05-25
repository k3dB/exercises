default rel

section .data

juice_times dd 1, 3, 3, 4, 5, 4, 7, 10

section .text

global time_to_make_juice
global time_to_prepare
global limes_to_cut
global remaining_orders

time_to_make_juice:
    ; This function has one argument, the ID for a juice as a 32-bit number.
    ; It returns the time to prepare this juice, as a 32-bit number.
    lea rdx, [juice_times]
    mov eax, dword [rdx + 4 * rdi - 4]
    ret

time_to_prepare:
    ; This function has two arguments:
    ; - An array with the IDs for ordered juices, each ID a 32-bit number.
    ; - The number of ordered juices, also a 32-bit number.
    ; It returns the total time to prepare all ordered juices,
    ; as a 32-bit number.
    xor eax, eax              ; Total time to prepare all orders
    xor ecx, ecx              ; Order index
    lea rdx, [juice_times]    ; Base address of juice times array

.next_order:
    cmp rcx, rsi
    je  .done
    mov r8d, dword [rdi + 4 * rcx]    ; Get current order ID
    mov r9d, dword [rdx + 4 * r8 - 4] ; Get current juice time
    add rax, r9                       ; Add to total time
    inc ecx                           ; Next order index
    jmp .next_order

.done:
    ret

limes_to_cut:
    ; This function takes three arguments:
    ; - The number of wedges needed, as a 32-bit number.
    ; - An array with the current supply of limes, each represented by an
    ;   8-bit number.
    ; - The number of limes in the supply, as a 32-bit number.
    ; It returns the number of limes that need to be cut, as a 32-bit number.
    xor eax, eax              ; Start with no limes
    xor ecx, ecx              ; Total number of wedges produced

.next_whole_lime:
    cmp eax, edx              ; More limes in supply?
    je  .done                 ; If not, there is nothing more to count
    mov r8b, byte [rsi + rax] ; Othewise, get the size of the current lime
    inc eax                   ; Count current lime
    cmp r8b, 'S'              ; Add appropriate number of wedges per lime size
    je  .small
    cmp r8b, 'M'
    je  .medium
.large:
    add ecx, 10
    jmp .check_amount

.medium:
    add ecx, 8
    jmp .check_amount

.small:
    add ecx, 6

.check_amount:
    cmp ecx, edi              ; Do we have enough wedges?
    jb  .next_whole_lime      ; If not, continue with next lime

.done:
    ret

remaining_orders:
    ; This function takes two arguments:
    ; - The time left in the shift, as a 32-bit number.
    ; - An array  with the IDs for ordered juices still not prepared,
    ;   each ID a 32-bit number.
    ; It returns the number of juices made before the shift ends,
    ; as a 32-bit number.
    ;
    ; Assumptions on usage:
    ; - The array is never empty.
    ; - The time left in the shift at the beginning is always greater than 0.
    ; - There are more orders in the array than that which can be prepared
    ;   before the shift ends.
    xor eax, eax              ; Number of orders left to make for the day
    xor ecx, ecx              ; Order index
    lea rdx, [juice_times]    ; Base address
    xor r10, r10              ; Total time of orders left to make

.next_order:
    inc eax                           ; Count order and get time for it
    mov r8d, dword [rsi + 4 * rcx]    ; Get current order ID
    mov r9d, dword [rdx + 4 * r8 - 4] ; Get current juice time
    add r10d, r9d                     ; Add time for current order to total
    inc ecx                           ; Next order index
    cmp r10, rdi                      ; Time limit reached?
    jb  .next_order                   ; If not, continue

    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
