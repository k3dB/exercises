section .text

global create
global add_minutes
global subtract_minutes
global equal

; clock_time_t create(int64_t hour, int64_t minute)
create:
    mov   rax, rdi        ; Convert hour parameter to minutes
    mov   rcx, 60         ; Number of minutes per hour
    imul  rcx
    add   rax, rsi        ; Add minute parameter to get total minutes
    cqo                   ; Sign extend RDX for signed division
    idiv  rcx             ; Convert total minutes to hours and minutes
    mov   rsi, rdx        ; Preserve simplified minutes (still signed)

    cqo                   ; Sign extend for signed division
    mov   r10, 24         ; Trim days to get remaining hours
    idiv  r10

    xor   r8, r8          ; Use to convert minutes to positive
    cmp   rsi, 0          ; Check if minutes value is negative
    cmovl r8, rcx         ; If negative, convert to positive
    setl  dil             ; Adjust the hours if needed
    movzx rdi, dil        ; Clear upper bits so the full register is 0 or 1
    sub   rdx, rdi        ; Adjust hours (still signed)
    add   rsi, r8         ; Adjust minutes (now unsigned)

    xor   r8, r8          ; Use to convert hours to positive
    cmp   rdx, 0          ; Check if hours value is negative
    cmovl r8, r10         ; If negative, convert to positive
    add   rdx, r8         ; Adjust hours (now unsigned)

    mov   rax, rdx        ; Prepare hours for return
    shl   rsi, 8          ; Shift remaining minutes to high byte
    or    rax, rsi        ; Combine remaining minutes with hours
    ret

; clock_time_t add_minutes(int64_t hour, int64_t minute, int64_t value)
add_minutes:
    add   rsi, rdx        ; Add value to minutes
    call  create
    ret

; clock_time_t subtract_minutes(int64_t hour, int64_t minute, int64_t value)
subtract_minutes:
    sub   rsi, rdx        ; Subtract value from minutes
    call  create
    ret

; bool equal(clock_time_t clock1, clock_time_t clock2)
equal:
    ; Using R11 to avoid using the stack since R11 is not used in the create
    ; function which is the only function called in this function.
    mov   r11, rsi        ; Preserve second clock
    mov   si, di          ; Copy full first clock
    shr   si, 8           ; Shift off the hours to get the minutes
    call  create          ; Create new clock from first clock to normalize

    mov   rsi, r11        ; Restore second clock value
    mov   r11, rax        ; Preserve normalized first clock

    mov   di, si          ; Copy full second clock
    shr   si, 8           ; Shift off the hours to get the minutes
    call  create          ; Create new clock from second clock to normalize

    cmp   rax, r11        ; Check if the two normalized clocks are the same
    sete  al
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
