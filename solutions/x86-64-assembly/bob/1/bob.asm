default rel

section .rodata
; Responses
question:        db "Sure.", 0
yell:            db "Whoa, chill out!", 0
yelled_question: db "Calm down, I know what I'm doing!", 0
silence:         db "Fine. Be that way!", 0
statement:       db "Whatever.", 0

; Flags
; 0 0 0 0  1 1 1 1
;    1 ->  | | | Non-white-space found (not silence)
;    2 ->  | | Lower letter found
;    4 ->  | Upper case letter found
;    8 ->  Last non-white-space is question mark

question_mask        equ 8
clear_question_mask  equ 7
upper_mask           equ 4
non_white_space_mask equ 1

upper_shift equ 2
lower_shift equ 1

section .text
global response
response:
    xor   cl, cl          ; Clear flags

.next_byte:
    mov   dl, [rdi]       ; Get current byte
    test  dl, dl          ; More bytes to parse?
    jz    .respond        ; If not, respond to Bob
    inc   rdi             ; Set up next byte

    cmp   dl, 0x20        ; Ignore spaces
    je    .next_byte
    cmp   dl, 0x09        ; Ignore tabs
    je    .next_byte
    cmp   dl, 0x0D        ; Ignore carriage returns
    je    .next_byte
    cmp   dl, 0x0A        ; Ignore line feeds
    je    .next_byte

    or    cl, non_white_space_mask

    cmp   dl, '?'         ; Check for question mark
    je    .handle_question_mark

    and   cl, clear_question_mask

    cmp   dl, 'A'         ; Check if upper case
    setge r8b
    cmp   dl, 'Z'
    setle r9b
    and   r8b, r9b
    shl   r8b, upper_shift
    or    cl, r8b

    cmp   dl, 'a'         ; Check if lower case
    setge r8b
    cmp   dl, 'z'
    setle r9b
    and   r8b, r9b
    shl   r8b, lower_shift
    or    cl, r8b

    jmp   .next_byte

.handle_question_mark:
    or    cl, question_mask
    jmp   .next_byte

.respond:
    test  cl, cl          ; Are any flags set?
    jz    .silence        ; If none were set, it is considered silence

    ; Clear non-white-space flag to simplify checking other flags
    and   cl, 0xFE

    ; Yelled question?
    mov   dl, question_mask
    or    dl, upper_mask
    cmp   cl, dl
    je    .yelled_question

    ; Yelled, but not a question?
    mov   dl, upper_mask
    cmp   cl, dl
    je    .yell

    ; Check if not a question (and, therefore, a statement) by clearing
    ; the other flags and seeing if the question flag is set.
    and   cl, question_mask
    mov   dl, question_mask
    test  cl, dl
    jz    .statement      ; Question flag was off

    jmp   .question       ; Only option left is question

.question:
    lea   rax, [question]
    ret

.yelled_question:
    lea   rax, [yelled_question]
    ret

.yell:
    lea   rax, [yell]
    ret

.statement:
    lea   rax, [statement]
    ret

.silence:
    lea   rax, [silence]
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
