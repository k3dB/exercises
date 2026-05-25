default rel

section .data

; Array of 8 bytes. Since there are only 7 days in a week,
; the last value is always zero.
prior_week_counts db 0, 2, 5, 3, 7, 8, 4, 0

section .bss

; Again the last value will always be zero.
this_week_counts resb 8

; Using qword for number of days to make sure all upper bits of register are
; cleared when using the value as a memory offset.
number_of_days_this_week resq 1

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
    mov   rax, qword [prior_week_counts]
    ret

current_week_counts:
    ; This function takes no parameter
    ; It returns two values:
    ; - A copy of current week's counts as a 8-byte number.
    ; - The number of days already filled in the current week, as a 8-byte number.
    ; All days after the most recent one should have its corresponding byte
    ; zeroed-out in the output
    ; At the start of the program, there is no count for the current week
    mov   rax, qword [this_week_counts]
    mov   rdx, qword [number_of_days_this_week]
    ret

save_count:
    ; This function takes as parameter the most recent count, as a 1-byte number
    ; It saves this value in a new entry for the current week
    ; If there is already 7 entries in the current week before the function is
    ; called, then:
    ; - The current week becomes the last week.
    ; - A new entry is added with the passed value in a new current week.
    ; The function has no return value
    lea   r9, [this_week_counts]  ; Load base memory address of current week
    mov   rdx, qword [number_of_days_this_week]
    cmp   rdx, 7                   ; Is the current week full?
    je    .start_new_week

    lea   rax, [r9 + rdx]         ; Offset for current day count
    mov   byte [rax], dil         ; Store input value in memory
    inc   rdx                     ; Update number of days recorded this week
    mov   qword [number_of_days_this_week], rdx
    ret

.start_new_week:
    mov   rax, qword [this_week_counts]
    mov   qword [prior_week_counts], rax
    mov   qword [r9], rdi         ; Store input value and set day count to one
    mov   qword [number_of_days_this_week], 1
    ret

today_count:
    ; This function has no parameter
    ; It returns the most recent entry for the current week, as a 1-byte number
    ; Behavior is undefined if no count is currently recorded
    mov   rcx, qword [number_of_days_this_week]
    dec   rcx                     ; Index of last day recorded
    lea   rdx, [this_week_counts] ; Get base address
    mov   al, byte [rdx + rcx]    ; Return value of last day recorded
    ret

update_today_count:
    ; This function takes as parameter a 1-byte number
    ; It adds this number to the most recent entry for the current week
    ; This function has no return value
    mov   rcx, qword [number_of_days_this_week]
    dec   rcx                     ; Index of last day recorded
    lea   rdx, [this_week_counts] ; Get base address
    add   byte [rdx + rcx], dil   ; Add input to existing value
    ret

update_week_counts:
    ; This function takes as parameter a 8-byte number
    ; Each byte in the input parameter, but the last, represents a day's count
    ; in the current week
    ; The last byte in the input parameter has no meaning and must be zeroed-out
    ; This function makes the following changes:
    ; - The current week becomes the last week.
    ; - The counts in the input parameter are fully inserted in the current week.
    mov   rax, qword [this_week_counts]
    mov   qword [prior_week_counts], rax
    mov   qword [this_week_counts], rdi
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
