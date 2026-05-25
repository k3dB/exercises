default rel

section .data

; Array of 8 bytes. Since there are only 7 days in a week,
; the last value is always zero.
prior_week_counts db 0, 2, 5, 3, 7, 8, 4, 0

section .bss

; Again the last value will always be zero.
this_week_counts resb 8
number_of_days_this_week resb 1

section .text

global last_week_counts
global current_week_counts
global save_count
global today_count
global update_today_count
global update_week_counts

last_week_counts:
    ; This function takes no parameter
    ; It returns a copy of last week's counts as a 8-byte number
    ; At the start of the program, last week's counts are 0, 2, 5, 3, 7, 8 and 4
    ; The last byte of the return value is always zero
    mov   rax, [prior_week_counts]
    ret

current_week_counts:
    ; This function takes no parameter
    ; It returns two values:
    ; - A copy of current week's counts as a 8-byte number.
    ; - The number of days already filled in the current week, as a 8-byte number.
    ; All days after the most recent one should have its corresponding byte zeroed-out in the output
    ; At the start of the program, there is no count for the current week
    xor   edx, edx ; Clear RDX because we only care about the last 8 bits
    mov   rax, qword [this_week_counts]
    mov   dl, byte [number_of_days_this_week]
    ret

save_count:
    ; This function takes as parameter the most recent count, as a 1-byte number
    ; It saves this value in a new entry for the current week
    ; If there is already 7 entries in the current week before the function is called, then:
    ; - The current week becomes the last week.
    ; - A new entry is added with the passed value in a new current week.
    ; The function has no return value
    xor   edx, edx
    lea   r9, [this_week_counts]  ; Load base memory address of current week
    mov   dl, byte [number_of_days_this_week]
    cmp   dl, 7                   ; Is the current week full?
    jz    .start_new_week

    lea   rax, [r9 + rdx]         ; Offset for current day count
    mov   byte [rax], dil         ; Store input value in memory
    inc   dl                      ; Update number of days recorded this week
    mov   byte [number_of_days_this_week], dl
    ret

.start_new_week:
    lea   r8, [prior_week_counts]
    xor   ecx, ecx                ; Index of day to copy

.copy_next_day:
    mov   al, byte [r9 + rcx]     ; Current week at current index
    mov   byte [r8 + rcx], al     ; Copy value to prior week at same index
    inc   ecx                     ; Advance to next day index
    cmp   ecx, 7                  ; Are we finished copying?
    jne   .copy_next_day

    mov   qword [r9], rdi         ; Store input value into memory
    mov   byte [number_of_days_this_week], 1
    ret

today_count:
    ; This function has no parameter
    ; It returns the most recent entry for the current week, as a 1-byte number
    ; Behavior is undefined if no count is currently recorded
    xor   eax, eax                ; Clear registers
    xor   ecx, ecx
    mov   cl, byte [number_of_days_this_week]
    dec   cl                      ; Index of last day recorded
    lea   rdx, [this_week_counts] ; Get base address
    mov   al, byte [rdx + rcx]    ; Return value of last day recorded
    ret

update_today_count:
    ; This function takes as parameter a 1-byte number
    ; It adds this number to the most recent entry for the current week
    ; This function has no return value
    call  today_count
    add   al, dil
    ; today_count leaves base address in RDX and offset in RCX
    mov   byte [rdx + rcx], al
    ret

update_week_counts:
    ; This function takes as parameter a 8-byte number
    ; Each byte in the input parameter, but the last, represents a day's count in the current week
    ; The last byte in the input parameter has no meaning and must be zeroed-out
    ; This function makes the following changes:
    ; - The current week becomes the last week.
    ; - The counts in the input parameter are fully inserted in the current week.
    lea   r8, [prior_week_counts]
    lea   r9, [this_week_counts]
    xor   ecx, ecx                ; Index of day to copy
    xor   eax, eax                ; Clear RAX

.copy_next_day:
    mov   al, byte [r9 + rcx]     ; Get next count from current week
    mov   byte [r8 + rcx], al     ; Copy value to prior week at same index
    inc   ecx                     ; Advance to next day index
    cmp   ecx, 7                  ; Are we finished copying?
    jne   .copy_next_day

    xor   ecx, ecx                ; Reset index for current week

.save_week_counts:
    mov   byte [r9 + rcx], dil    ; Store each byte from input value into memory
    shr   rdi, 8                  ; Shift off the byte we just stored
    inc   ecx                     ; Next day index
    cmp   ecx, 7                  ; Are we finished storing this week's counts?
    jne   .save_week_counts

    mov   byte [number_of_days_this_week], 7
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
