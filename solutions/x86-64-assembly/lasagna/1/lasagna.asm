EXPECTED_MINUTES_IN_OVEN equ 40
MINUTES_PER_LAYER equ 2

section .text

global expected_minutes_in_oven
expected_minutes_in_oven:
    mov   eax, EXPECTED_MINUTES_IN_OVEN
    ret

global remaining_minutes_in_oven
remaining_minutes_in_oven:
    ; Note that RDI could be clobbered by a function call, but this learning
    ; exercise did not cover pushing registers to the stack. The functions seem
    ; to be designed to not need to preserve registers.
    call  expected_minutes_in_oven ; Does not clobber RDI
    sub   eax, edi                 ; Subtract input from expected minutes
    ret

global preparation_time_in_minutes
preparation_time_in_minutes:
    mov   eax, edi                 ; Copy input
    imul  eax, MINUTES_PER_LAYER   ; Following learning concepts
    ; shl eax, 1 ; More efficient way to double an integer
    ret

global elapsed_time_in_minutes
elapsed_time_in_minutes:
    ; RDI already contains the parameter for the following function call.
    ; Again, normally RSI would be preserved on the stack before making a
    ; function call since its value in the current function is used after
    ; the call.
    call  preparation_time_in_minutes ; Does not clobber RSI
    add   eax, esi
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
