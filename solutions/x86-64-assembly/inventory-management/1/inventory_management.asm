WEIGHT_OF_EMPTY_BOX equ 500
TRUCK_HEIGHT equ 300
PAY_PER_BOX equ 5
PAY_PER_TRUCK_TRIP equ 220

section .text

global get_box_weight
get_box_weight:
    ; This function takes the following parameters:
    ; - The number of items for the first product in the box, as a 16-bit non-negative integer
    ; - The weight of each item of the first product, in grams, as a 16-bit non-negative integer
    ; - The number of items for the second product in the box, as a 16-bit non-negative integer
    ; - The weight of each item of the second product, in grams, as a 16-bit non-negative integer
    ; The function returns the total weight of a box, in grams, as a 32-bit non-negative integer
    mov   eax, ecx                 ; Get weight of second product, first,
    mul   edx                      ; because RDX gets clobbered by MUL
    mov   rcx, rax                 ; Preserve weight of first product
    mov   eax, edi                 ; Get weight of first product
    mul   esi                      ; 32-bit multiplication to get full result in RAX
    add   rax, rcx                 ; Add both product weights
    add   rax, WEIGHT_OF_EMPTY_BOX ; Add weight of box for total weight
    ret

global max_number_of_boxes
max_number_of_boxes:
    ; This function takes the following parameter:
    ; - The height of the box, in centimeters, as a 8-bit non-negative integer
    ; The function returns how many boxes can be stacked vertically, as a 8-bit non-negative integer
    mov   ax, TRUCK_HEIGHT
    div   di
    ret

global items_to_be_moved
items_to_be_moved:
    ; This function takes the following parameters:
    ; - The number of items still unaccounted for a product, as a 32-bit non-negative integer
    ; - The number of items for the product in a box, as a 32-bit non-negative integer
    ; The function returns how many items remain to be moved, after counting those in the box, as a 32-bit integer
    sub   edi, esi
    mov   eax, edi
    ret

global calculate_payment
calculate_payment:
    ; This function takes the following parameters:
    ; - The upfront payment, as a 64-bit non-negative integer
    ; - The total number of boxes moved, as a 32-bit non-negative integer
    ; - The number of truck trips made, as a 32-bit non-negative integer
    ; - The number of lost items, as a 32-bit non-negative integer
    ; - The value of each lost item, as a 64-bit non-negative integer
    ; - The number of other workers to split the payment/debt with you, as a 8-bit positive integer
    ; The function returns how much you should be paid, or pay, at the end, as a 64-bit integer (possibly negative)
    ; Remember that you get your share and also the remainder of the division
    mov   rax, PAY_PER_TRUCK_TRIP
    mul   rdx
    mov   r10, rax         ; Start total with payment for truck trips

    mov   rax, PAY_PER_BOX
    mul   rsi
    add   r10, rax         ; Add payment for boxes
    sub   r10, rdi         ; Subtract initial cost

    mov   rax, rcx
    mul   r8
    sub   r10, rax         ; Subtract losses

    inc   r9               ; Add self to total payment pool
    mov   rax, r10
    cqo
    idiv  r9               ; Divide total payment/debt by total payment pool
    add   rax, rdx         ; Include remainder in your payment

    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
