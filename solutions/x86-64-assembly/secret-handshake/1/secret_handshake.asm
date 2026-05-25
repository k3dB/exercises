default rel

section .rodata

wink            db "wink", 0
double_blink    db "double blink", 0
close_your_eyes db "close your eyes", 0
jump            db "jump", 0
separator       db ", ", 0

align 8
actions dq wink, double_blink, close_your_eyes, jump
flags   dq    1,            2,               4,    8

section .text

%macro copy_string 0
%%next_byte:
    mov   al, byte [rsi]  ; Check if there are more bytes
    test  al, al
    jz    %%end_copy
    movsb
    jmp   %%next_byte
%%end_copy:
%endmacro

global commands

; void commands(char *buffer, int number)
commands:
    mov   cl, 4           ; Total possible actions
    xor   r11, r11        ; Separator flag
    mov   edx, esi        ; Copy input so RSI can be used for MOVS
    mov   r8, 3           ; Initialize to last action index
    mov   eax, 16         ; Reverse flag
    and   eax, edx        ; Check if reverse flag is set
    test  eax, eax
    cmovz r8d, eax        ; If not set, start at the first action index
    mov   r9,  -1         ; Backward direction
    mov   r10, 1          ; Forward direction
    test  r8, r8          ; Starting at beginning?
    cmovz r9, r10         ; If so, move in the forward direction

.next_action:
    test  cl, cl          ; Are we done?
    jz    .done
    dec   cl              ; Count down number of actions visited

    lea   r10, [flags]    ; Get current flag under test
    mov   al, byte [r10 + 8 * r8]
    and   al, dl          ; Check if current action is in input
    test  al, al
    jz    .skip_action    ; If not move to next action
    test  r11, r11        ; Skip separator on first item
    jz    .store_action
    lea   rsi, [separator]
    copy_string           ; Copy separator

.store_action:
    lea   rsi, [actions]  ; Get current action text
    mov   rsi, [rsi + 8 * r8]
    copy_string           ; Copy current action
    or    r11, 1          ; Insert separator after first item

.skip_action:
    add   r8, r9          ; Prepare next index
    jmp   .next_action

.done:
    mov   byte [rdi], 0   ; Null-terminate output
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
