default rel

section .text

%macro swap 2
    xor %1, %2      ; Values are already tested to not be equal,
    xor %2, %1      ; so we can use XOR swapping
    xor %1, %2
%endmacro

global latest
global personal_best
global personal_top_three

; int32_t latest(size_t scores_count, const int32_t *scores)
latest:
    ; This function returns the last element in the input array.
    mov eax, dword [rsi + 4 * rdi - 4]
    ret

; int32_t personal_best(size_t scores_count, const int32_t *scores)
personal_best:
    ; This function returns the greatest element in the input array.
    mov  eax, dword [rsi]    ; Start with first score

.next_score:
    dec  rdi                 ; Start with last score index going to first
    test rdi, rdi            ; Are there more scores to check?
    jl   .done               ; If not, we are done, otherwise, get current score
    mov  edx, dword [rsi + 4 * rdi]
    cmp  edx, eax            ; Is this score more than the current highest?
    jle  .next_score         ; If not, check the next score
    mov  eax, edx            ; Otherwise, replace highest with current score
    jmp  .next_score

.done:
    ret

; size_t personal_top_three(
;     int32_t *buffer,
;     const int32_t *scores,
;     size_t scores_count)
personal_top_three:
    ; This function writes in the output buffer up to the three greatest
    ; elements in the input array, and returns the size of this buffer.
    mov  rax, rdx                   ; Start with number of scores
    cmp  rax, 3                     ; Check if there are more than three
    jle  .use_full_size             ; If not, return the full set
    mov  rax, 3                     ; Otherwise, limit to three highest
.use_full_size:
    xor  r9, r9                     ; Clear registers to load data for buffer
    xor  r10, r10
    xor  r11, r11

.next_score:
    dec  edx                        ; Start from last score index going to first
    test edx, edx                   ; Are there more scores to check?
    jl   .load_buffer               ; If not, load buffer with highest scores
    mov  r8d, dword [rsi + 4 * rdx] ; Otherwise, get current score under test

    cmp  r8d, r9d                   ; Is the score under test > first score
    jle  .no_swap_1                 ; If not, skip swap
    swap r8d, r9d                   ; Otherwise, swap values
.no_swap_1:

    cmp  r8d, r10d                  ; Is the score under test > second score
    jle  .no_swap_2                 ; If not, skip swap
    swap r8d, r10d                  ; Otherwise, swap values
.no_swap_2:

    cmp  r8d, r11d                  ; Is the score under test > third score
    jle  .next_score                ; If not, check next score (no swap)
    swap r8d, r11d                  ; Otherwise, swap values
    jmp .next_score

.load_buffer:
    mov  dword [rdi], r9d           ; Load values from registers to buffer
    mov  dword [rdi + 4], r10d
    mov  dword [rdi + 8], r11d
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
