default rel

section .data

; Assumes only English lowercase letters for keys and values will not be zero.
; Zero means no value was recorded for that key.
sorted_values times 26 dd 0      ; Store new map values in sorted order

; Types used:

;typedef struct {
;    int32_t key;
;    uint8_t values_size;
;    char values[ALPHABET_SIZE];
;} LegacyMap;

;typedef struct {
;    char key;
;    int32_t value;
;} NewMapEntry;

section .text

global transform

;size_t transform(
;    NewMapEntry     *output,
;    const LegacyMap *input,
;    size_t          input_size)
transform:
    ; Transforms a LegacyMap to a NewMapEntry and returns the count of how many
    ; NewMapEntry items are in the output.
    xor   rax, rax            ; Output index (last iteration adds one for count)
    xor   rcx, rcx            ; LegacyMap (input) index

.next_input:
    mov   r8d, dword [rsi]    ; Get current input key (output value)
    mov   r9b, byte [rsi + 4] ; Get current input letter count
    movzx r9, r9b             ; Clear other bytes to use in memory offset
    add   rsi, 5              ; Point to first input value (letter)

.next_letter:
    dec   r9b                   ; Count down the letters
    mov   r11b, byte [rsi + r9] ; Get next legacy letter (backward)
    movzx r11, r11b             ; Clear other bytes to use in memory offset
    sub   r11b, 'A'             ; Convert letter to index
    lea   r10, [sorted_values]  ; Store value in sorted array (by letter index)
    mov   dword [r10 + 4 * r11], r8d
    inc   rax                   ; Next output index (or count if no more input)
    test  r9b, r9b              ; More input letters?
    jnz   .next_letter

    add   rsi, 27             ; Point to next LegacyMap item
    inc   rcx                 ; Next LegacyMap index
    cmp   rcx, rdx            ; More LegacyMap items?
    jne   .next_input

    xor   rcx, rcx            ; Sorted value index
    xor   r10, r10            ; Output index

.next_key:
    lea   r8, [sorted_values] ; Get values in sorted (index) order
    mov   edx, dword [r8 + 4 * rcx]
    inc   rcx                 ; Next sorted value index
    test  edx, edx            ; Is there a value at this index?
    jz    .next_key           ; If not, continue

    mov   r9, rcx             ; Key index (after advanced)
    dec   r9                  ; Back up to actual index (unadvance)
    add   r9b, 'a'            ; Convert index to key

    ; Store key and value in ouput
    mov   byte [rdi + 8 * r10], r9b
    mov   dword [rdi + 8 * r10 + 4], edx

    inc   r10                 ; Next output index
    cmp   rcx, 26             ; Any more keys to check?
    jb    .next_key

    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
