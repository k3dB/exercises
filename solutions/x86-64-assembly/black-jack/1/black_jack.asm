C2 equ 2
C3 equ 3
C4 equ 4
C5 equ 5
C6 equ 6
C7 equ 7
C8 equ 8
C9 equ 9
C10 equ 10
CJ equ 11
CQ equ 12
CK equ 13
CA equ 14

TRUE equ 1

section .text

global value_of_card
value_of_card:
    ; This function takes as parameter a number representing a card
    ; The function returns the numerical value of the passed-in card
    mov   rax, 1          ; Ace will always return one for this function
    cmp   rdi, CA
    je    .done

    mov   rax, 10         ; Face cards are worth 10 each
    cmp   rdi, C10
    ja    .done

    mov   rax, rdi        ; Number cards are worth the number on the card

.done:
    ret

global higher_card
higher_card:
    ; This function takes as parameters two numbers each representing a card
    ; The function should return which card has the higher value
    ; If both have the same value, both should be returned
    ; If one is higher, the second one should be 0
    call  value_of_card   ; Get value of first card
    mov   r10, rax

    mov   rcx, rdi        ; Preserve first parameter
    mov   rdi, rsi
    call  value_of_card   ; Get value of second card
    mov   r11, rax

    mov   rax, rcx        ; Return both if the have equal value
    mov   rdx, rsi
    cmp   r10, r11
    je    .done

    xor   rdx, rdx        ; Clear RDX if not the same

    mov   rax, rcx        ; Return first if higher
    cmp   r10, r11
    ja    .done

    mov   rax, rsi        ; Second must be higher if we reached this point
.done:
    ret

global value_of_ace
value_of_ace:
    ; This function takes as parameters two numbers each representing a card
    ; The function returns the value of an upcoming ace
    call  value_of_card   ; Get value of first card
    mov   r10, rax

    mov   rdi, rsi
    call  value_of_card   ; Get value of second card
    mov   r11, rax

    mov   rcx, r10        ; Get current score
    add   rcx, r11

    cmp   r10, 1          ; Is the first card an ace?
    je    .ace_found
    cmp   r11, 1          ; Is the second card an ace?
    je    .ace_found
    jmp   .decide

.ace_found:
    cmp   rcx, 11         ; Should current ace count as 11?
    ja    .decide         ; If not, decide on value of next ace
    add   rcx, 10         ; Otherwise, treat one existing ace as 11

.decide:
    cmp   rcx, 11         ; If current score is less then 11
    jl    .eleven         ; Next ace is eleven
    mov   rax, 1          ; Otherwise, next ace is a one
    ret

.eleven:
    mov   rax, 11
    ret

global is_blackjack
is_blackjack:
    ; This function takes as parameters two numbers each representing a card
    ; The function returns TRUE if the two cards form a blackjack, and FALSE otherwise
    cmp   rdi, C10        ; If the first card is less than 10,
    jl    .false          ; it is not a blackjack

    cmp   rsi, C10        ; If the second card is less than 10,
    jl    .false          ; it is not a blackjack

    cmp   rdi, CA
    je    .first_card_is_ace

    cmp   rsi, CA
    je    .second_card_is_ace

    jmp   .false          ; If neither card is an ace, it is not a blackjack

.first_card_is_ace:
    cmp   rsi, CA         ; If second card is also an ace,
    je    .false          ; it is not blackjack
    jmp   .true           ; Otherwise, it is blackjack

.second_card_is_ace:
    cmp   rdi, CA         ; If first card is also an ace,
    je    .false          ; it is not blackjack
    jmp   .true           ; Otherwise, it is blackjack

.true:
    mov   rax, TRUE       ; If we got here, it is blackjack
    ret

.false:
    xor   rax, rax
    ret

global can_split_pairs
can_split_pairs:
    ; This function takes as parameters two numbers each representing a card
    ; The function returns TRUE if the two cards can be split into two pairs, and FALSE otherwise
    call  value_of_card   ; Get value of first card
    mov   rcx, rax

    mov   rdi, rsi
    call  value_of_card   ; Get value of second card

    cmp   rax, rcx        ; Do the two cards have the same value?
    je    .true           ; If so, return true

    xor   rax, rax        ; Otherwise, return false
    ret

.true:
    mov  rax, TRUE
    ret

global can_double_down
can_double_down:
    ; This function takes as parameters two numbers each representing a card
    ; The function returns TRUE if the two cards form a hand that can be doubled down, and FALSE otherwise
    call  value_of_card   ; Get value of first card
    mov   r10, rax

    mov   rdi, rsi
    call  value_of_card   ; Get value of second card

    add   rax, r10        ; Get current score

    cmp   rax, 9          ; If the current score is less than 9,
    jb    .false          ; you cannot double down
    cmp   rax, 11         ; If the current score is greater than 11,
    ja    .false          ; you cannot double down

    mov   rax, TRUE       ; If we get here, you can double down
    ret

.false:
    xor   rax, rax
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
