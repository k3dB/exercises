default rel

section .rodata

; Each set of two bytes is a transcription complement pair
transcriptions db "GCCGTAAU", 0

section .text
global to_rna

to_rna:
    lea  r10, [rdi]

_next_input:
    mov  al, [r10]            ; Read next input byte
    cmp  al, 0                ; Reached end of input?
    je   _done                ; If so, then we are done
    inc  r10                  ; Otherwise, prepare for the next input byte
    lea  r11, [transcriptions]

_next_transcription:
    mov  dl, [r11]            ; Read next transcription pair
    cmp  dl, 0                ; Reached end of transcription pairs?
    je   _next_input          ; If so, ignore the edge case of invalid input
    inc  r11                  ; Point to transcription complement
    cmp  al, dl               ; Found the current input value?
    je   _found               ; If so, transcribe it
    inc  r11                  ; Otherwise, continue looking for a match
    jmp  _next_transcription

_found:
    mov  dl, [r11]            ; Read transcribed nucleotide
    mov  [rsi], dl            ; Store transcription in output buffer
    inc  rsi                  ; Prepare for next output byte
    jmp  _next_input

_done:
    xor  edx, edx
    mov  [rsi], edx           ; Null-terminate output
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
