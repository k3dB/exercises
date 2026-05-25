default rel

ENTRY_SIZE equ 120

section .rodata

print_intro:
    db "Item Details", `\n`,
    db "------------", 0

section .text

global create_item_entry
global create_monthly_list
global insert_found_item
global print_item

create_item_entry:
    ; This function may take any number of parameters, of which the first 6 are:
    ;
    ; 1. The address for a location in memory where the item should be stored.
    ; 2. The ID for the item, as a 64-bit unsigned integer.
    ; 3. The address for a string with the item's description.
    ; 4. The day it was found, as a 64-bit unsigned integer.
    ; 5. The month it was found, as a 64-bit unsigned integer.
    ; 6. The number of categories for the item, as a 64-bit unsigned integer.
    ; Each subsequent parameter is the address for a string with one of the
    ; categories.
    ;
    ; Values are stored in the provided memory location in the same order of the
    ; arguments:
    ; ID, description, day, month, number of categories,
    ; and each category in order.
    ;
    ; This function has no return value.
    mov   qword [rdi +  0], rsi  ; Store ID
    mov   qword [rdi +  8], rdx  ; Store description
    mov   qword [rdi + 16], rcx  ; Store day
    mov   qword [rdi + 24], r8   ; Store month
    mov   qword [rdi + 32], r9   ; Store number of categories
    mov   rcx, 8                 ; Stack offset
    mov   rdx, 40                ; Category offset

.next_category:
    test  r9, r9                 ; More categories?
    jz    .done                  ; If so, we are done
    dec   r9                     ; Otherwise, count down to zero categories
    mov   rax, qword [rsp + rcx] ; Get current category address
    mov   qword [rdi + rdx], rax ; Store current category
    add   rcx, 8                 ; Next stack parameter offset
    add   rdx, 8                 ; Next category offset
    jmp   .next_category

.done:
    ret

create_monthly_list:
    ; This function takes as parameters:
    ;
    ; 1. The capacity of the array in bytes, as a 64-bit unsigned integer.
    ; 2. An allocator function.
    ;
    ; The allocator function should be called with the capacity as argument.
    ; It returns the address of the allocated space.
    ; This space has undefined value and should be cleared.
    ;
    ; This function returns the address for the space allocated with the
    ; allocator function.
    push rdi              ; Preserve capacity for later use
    call rsi              ; Call the allocator
    mov  rdi, rax         ; Put address in RDI for storing zeros
    mov  rdx, rdi         ; Make a copy of the initial address to return later
    pop  rcx              ; Recall the capacity into RCX for REP count
    xor  eax, eax         ; Clear RAX for the zeros to be stored
    rep  stosb            ; Store the zeros at the given address
    mov  rax, rdx         ; Return the initial address
    ret

insert_found_item:
    ; This function takes as parameters:
    ;
    ; 1. The address for a space in memory where the monthly list is located.
    ; 2. The current number of entries already stored in the list, as a 64-bit
    ;    unsigned integer.
    ; 3. A new entry to be added to the list.
    ;
    ; You may consider that the new entry always fits into the list.
    ; All entries in the list take up 120 bytes in space.
    ; This function has no return value.
    mov  rax, ENTRY_SIZE   ; Get memory offset to store new entry
    mul  rsi               ; Note assuming less than 76 quadrillion entries
    add  rdi, rax          ; Apply offset (again, assuming nothing in RDX)
    mov  rsi, rsp          ; Address for new entry is first parameter on stack
    add  rsi, 8
    mov  rcx, ENTRY_SIZE   ; Store new entry
    rep  movsb
    ret

print_item:
    ; This function takes as parameters:
    ;
    ; 1. The address for a buffer where an introductory ASCII NUL-terminated
    ;    string may be stored.
    ; 2. The address for a space in memory where the monthly list is located.
    ; 3. The index of the entry in the array for the item that should be
    ;    printed, as a 64-bit unsigned integer.
    ; 4. A printing function.
    ;
    ; This function calls the printing function with the following arguments:
    ;
    ; 1. The address to a memory location where the introductory string is
    ;    stored; or `0` (as a 64-bit integer) if no string is passed.
    ; 2. The index of the entry in the array for the item that should be
    ;    printed, as a 64-bit unsigned integer.
    ; 3. The ID for the item, as a 64-bit unsigned integer.
    ; 4. The address for a string with the item's description.
    ; 5. The day the item was found, as a 64-bit unsigned integer.
    ; 6. The month the item was found, as a 64-bit unsigned integer.
    ; 7. The number of categories for the item, as a 64-bit unsigned integer.
    ; 8. The address of the first category string.
    ;
    ; The introductory string is optional.
    ; If it is used in the printing function, this string must be NUL-terminated
    ; (ending in `0`) and have at most 50 characters, already considering the
    ; NUL terminator.
    ; Otherwise, the value `0` should be passed to the printing function
    ; instead.
    ;
    ; This function has no return value.
    push  rbp             ; Prologue
    mov   rbp, rsp
    sub   rsp, 16         ; Reserve space for two stack parameters
    mov   r10, rcx        ; Copy address of print function to call
    push  rdx             ; Preserve RDX from MUL operation
    mov   rax, ENTRY_SIZE ; Get offset of entry to print
    mul   rdx
    add   rax, rsi
    lea   rdi, [print_intro]
    pop   rsi             ; Recall index to start setting up print function call
    mov   rdx, qword [rax +  0]
    mov   rcx, qword [rax +  8]
    mov   r8,  qword [rax + 16]
    mov   r9,  qword [rax + 24]
    lea   r11, [rax + 40] ; Push stack parameters in reverse order
    push  r11
    push  qword [rax + 32]
    call  r10             ; Call the print function
    mov   rsp, rbp        ; Epilogue
    pop   rbp
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
