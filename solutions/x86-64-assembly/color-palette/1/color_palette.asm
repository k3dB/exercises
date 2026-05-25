default rel

section .rodata

RED   dd 0xFF000000
GREEN dd 0x00FF0000
BLUE  dd 0x0000FF00

global RED
global GREEN
global BLUE

section .data

base_color dd 0xFFFFFF00

global base_color
extern combining_function

section .text

global get_color_value
get_color_value:
    ; This function takes the address for a color as parameter
    ; It returns the 32-bit value associated with the color
    mov   rax, qword [rdi]
    ret

global add_base_color
add_base_color:
    ; This function takes the address for a color as parameter
    ; It saves the 32-bit value associated with this color in the variable 'base_color'
    ; This variable must be accessible from other source files
    ; This function has no return value
    mov  rax, qword [rdi]
    mov  qword [base_color], rax
    ret

global make_color_combination
make_color_combination:
    ; This function takes the following parameters:
    ; - The address where the 32-bit value for the combined color should be stored.
    ; - The address of a secondary color in the color table.
    ; This function calls 'combining_function' with the 32-bit value for base and
    ; secondary colors and store the result in the passed address
    ; This function has no return value
    push  rdi                     ; Preserve on stack for later
    mov   edi, dword [base_color] ; Set up external function call
    mov   esi, dword [rsi]
    call  combining_function      ; Make external function call
    pop   rdi                     ; Restore original first input value
    mov   dword [rdi], eax        ; Store value returned from external function
                                  ; in address containted in the first parameter
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
