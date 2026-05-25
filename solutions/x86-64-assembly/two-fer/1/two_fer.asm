default rel

section .rodata
prefix db "One for ", 0
person db "you", 0
suffix db ", one for me.", 0

section .text
global two_fer

two_fer:
    lea  rbx, [prefix]
    call copy_string

    dec  rsi           ; Remove null terminator to continue string
    lea  rbx, [person] ; Load default person
    cmp  rdi, 0        ; Did caller supply a person?
    je   copy_person   ; If not, use default we already loaded
    lea  rbx, [rdi]    ; Otherwise, use caller's value

copy_person:
    call copy_string

    dec  rsi           ; Remove null terminator to continue string
    lea  rbx, [suffix]
    call copy_string

    ret

copy_string:
    mov  al, [rbx]     ; Put character in AL
    mov  [rsi], al     ; Put in result buffer
    inc  rsi           ; Advance to next destination byte
    inc  rbx           ; Advance to next source byte
    cmp  al, 0         ; Look for null ternminator
    jne  copy_string

    ret 
