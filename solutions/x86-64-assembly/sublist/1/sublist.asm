; relation_t
UNEQUAL   equ 0
EQUAL     equ 1
SUBLIST   equ 2
SUPERLIST equ 3

section .text
global sublist

; relation_t sublist(
;    const int64_t *list_one,
;    size_t         list_one_count,
;    const int64_t *list_two,
;    size_t         list_two_count
; )
sublist:
    test rsi, rsi         ; Check if first list is empty
    setz r8b
    mov  al, r8b          ; Preserve result of first length check
    test rcx, rcx         ; Check if second list is empty
    setz r9b
    and  r8b, r9b         ; Are both lists empty?
    cmp  r8b, 1           ; If both are empty, they are equal
    je   .equal
    cmp  al, 1            ; If only the first is empty, it is a subset
    je   .sublist
    cmp  r9b, 1           ; If only the second is empty, the first is a superset
    je   .superlist

    xor  r11, r11         ; Set flag if first list is larger (superlist)
    cmp  rsi, rcx         ; If both lengths are equal, check if lists are equal
    jl   .check_sublist   ; Otherwise, check for a subset
    jg   .check_superlist

.next_equal:
    dec  rsi              ; Use counts as indexes and traverse the lists backard
    dec  rcx
    cmp  rsi, -1          ; Compared all elemets?
    je   .equal
    mov  r8, qword [rdi + 8 * rsi]
    mov  r9, qword [rdx + 8 * rcx]
    cmp  r8, r9           ; Compare values at the current index of each list
    jne  .unequal
    jmp  .next_equal

.check_superlist:
    inc  r11              ; Set flag for superlist result
    xchg rdi, rdx         ; Swap parameter order such that the subset is first
    xchg rsi, rcx

.check_sublist:
    xor  r8, r8           ; Small set index
    xor  r9, r9           ; Large set index

.next_large_set_item:
    cmp  r8, rsi          ; Reached end of small list?
    je   .valid_sublist
    cmp  r9, rcx          ; Reached end of large list?
    je   .unequal
    mov  rax, qword [rdx + 8 * r9]
    mov  r10, qword [rdi + 8 * r8]
    cmp  rax, r10         ; Copmare current large set with current small set
    je   .continue_search
    sub  r9, r8           ; Rewind the large set to start of sublist comparison
    inc  r9               ; Then move to the next large list item
    xor  r8, r8           ; Reset small set index for next sublist candidate
    jmp  .next_large_set_item

.continue_search:
    inc  r8               ; Sublist candidate, continue checking next item
    inc  r9               ; Next large list item
    jmp  .next_large_set_item

.valid_sublist:
    test r11, r11         ; Is original first list a sublist or superlist?
    jz   .sublist
    jmp  .superlist

.unequal:
    mov  rax, UNEQUAL
    ret

.equal:
    mov  rax, EQUAL
    ret

.sublist:
    mov  rax, SUBLIST
    ret

.superlist:
    mov  rax, SUPERLIST
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc nowrite progbits
%endif
