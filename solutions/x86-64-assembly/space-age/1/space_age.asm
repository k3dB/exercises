default rel

section .rodata

earth_seconds: dd 31557600.0

ratios:
    dd 0.2408467  ; Mercury
    dd 0.61519726 ; Venus
    dd 1.0        ; Earth
    dd 1.8808158  ; Mars
    dd 11.862615  ; Jupiter
    dd 29.447498  ; Saturn
    dd 84.016846  ; Uranus
    dd 164.79132  ; Neptune

section .text
global age

age:
    movss    xmm1, [earth_seconds]
    cvtsi2ss xmm0, esi             ; Convert seconds input to float
    divss    xmm0, xmm1            ; Earth seconds
    lea      r10,  [ratios]
    shl      rdi,  2               ; Calculate offset
    movss    xmm1, [r10 + rdi]     ; Get appropriate planet ratio
    divss    xmm0, xmm1            ; Planet seconds
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
