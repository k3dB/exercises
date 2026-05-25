section .text
global steps
steps:
; Note that the input is a signed 32-bit integer.
; The only place that must use 32-bit registers is the test for invalid
; input because the sign bit will be in the lower 32 bits.
; For consistency, we can use only 32-bit registers for the entire procedure.
    mov  eax, -1    ; Default to the error code
    test edi, edi   ; Is the (32-bit integer) input valid?
    jle  _done      ; If zero or negative, return error code
    xor  eax, eax   ; Otherwise, clear output for counting

_next:
    cmp  edi, 1     ; Have we reached a value of one?
    je   _done      ; If so, we are done
    inc  eax        ; Otherwise, increment step count

    test edi, 1     ; Is the current value odd?
    jz   _even

    imul edi, 3     ; If the number is odd, multiply it by 3
    inc  edi        ; And add one

; Since the 3x + 1 calculation gets us back to an even number, we can increment
; the step count again and continue to the next (even) step.
    inc  eax        ; Count the "even" step that follows

_even:
    shr  edi, 1     ; Divide by 2
    jmp  _next

_done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
