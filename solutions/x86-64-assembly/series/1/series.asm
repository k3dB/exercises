EMPTY_SERIES equ -1
ZERO_LENGTH equ -2
NEGATIVE_LENGTH equ -3
EXCESSIVE_LENGTH equ -4
SLICE_SIZE equ 20

section .text
global slices

; int64_t slices(char buffer[][SLICE_SIZE], const char *series, size_t slice_length)
slices:
    test  rdx, rdx             ; Is slice length zero?
    jz    .zero_length

    cmp   rdx, 0               ; Is slice length negative?
    jl    .negative_length

    xor   r8, r8               ; Count number of substrings in buffer
    xor   r9, r9               ; Buffer index
    xor   r10, r10             ; Count bytes in series

.next_length_byte:
    mov   al, byte [rsi + r10] ; Get next byte
    test  al, al               ; More bytes?
    jz    .finish_length
    inc   r10                  ; Count series byte
    jmp   .next_length_byte

.finish_length:
    test  r10, r10             ; Is the series length zero?
    jz    .empty_series
    sub   r10, rdx             ; Get stopping index
    jl    .excessive_length    ; Does slice length exceed series length?
    add   r10, rsi             ; Get stopping address
    inc   r10                  ; Handle off-by-one

.next_series_byte:
    cmp   rsi, r10             ; Reached stopping address?
    je    .done
    mov   rax, SLICE_SIZE      ; Get offset for next buffer substring
    mul   r9b
    lea   r11, [rdi + rax]     ; Address of current substring in buffer
    lea   r11, [r11]           ; Address of first byte of current substring
    xor   rcx, rcx             ; Clear substring index

.next_substring_byte:
    cmp   rcx, rdx             ; Done copying current substring?
    je    .finish_substring
    mov   al, byte [rsi + rcx] ; Get current substring byte
    mov   byte [r11 + rcx], al ; Store in buffer
    inc   rcx                  ; Next substring index
    jmp   .next_substring_byte

.finish_substring:
    mov   byte [r11 + rcx], 0  ; Null-terminate each substring
    inc   rsi                  ; Next source byte
    inc   r8                   ; Count substring when finished
    inc   r9                   ; Next buffer index
    jmp   .next_series_byte    ; Check next byte in series

.done:
    mov   rax, r8              ; Copy count to output
    ret

.excessive_length:
    mov   rax, EXCESSIVE_LENGTH
    ret

.zero_length:
    mov   rax, ZERO_LENGTH
    ret

.negative_length:
    mov   rax, NEGATIVE_LENGTH
    ret

.empty_series:
    mov   rax, EMPTY_SERIES
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
