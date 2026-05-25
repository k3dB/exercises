PRIVATE_KEY equ 0b1011_0011_0011_1100

section .text

global extract_higher_bits
global extract_lower_bits
global extract_redundant_bits
global set_message_bits
global rotate_private_key
global format_private_key
global decrypt_message

extract_higher_bits:
    ; This function takes a 16-bit integer as argument.
    ; It returns the higher 8-bit value of the argument.
    shr di, 8
    mov ax, di
    ret

extract_lower_bits:
    ; This function takes one 16-bit integer as argument.
    ; It returns the lower 8-bit value of the argument.
    and di, 0xFF
    mov ax, di
    ret

extract_redundant_bits:
    ; This function takes one 16-bit integer as argument.
    ; It returns a 8-bit integer with all bits set in both the lower and the higher 8 bits of the argument.
    mov ax, di
    shr di, 8
    and ax, di
    ret

set_message_bits:
    ; This function takes one 16-bit integer as argument.
    ; It returns a 8-bit integer with all bits set if they are set in the higher 8 bits of the argument,
    ; the others unchanged.
    mov ax, di
    shr di, 8
    or  ax, di
    ret

rotate_private_key:
    ; This function takes one 16-bit integer as argument.
    ; It returns a 16-bit integer with bits of the private key rotated to the left a number of positions
    ; equal to the redundant bits. A bit is redundant when it is set in both the lowest 8-bit portion of
    ; the argument and the highest 8-bit portion of the argument.
    mov    cx, di             ; Preserve original input before modifying
    shr    di, 8
    and    cx, di             ; Get redundant bits
    popcnt cx, cx             ; Count the set bits to get number to rotate by
    mov    ax, PRIVATE_KEY
    rol    ax, cl
    ret

format_private_key:
    ; This function takes one 16-bit integer as argument.
    ; It returns a 8-bit integer with the private key fully formatted.
    ; To format a private key, you must:
    ; - Rotate it.
    mov    cx, di             ; Copy/paste instead of making a call
    shr    di, 8
    and    cx, di
    popcnt cx, cx
    mov    ax, PRIVATE_KEY
    rol    ax, cl
    ; - Isolate the lowest 8-bit portion of the rotated private key, which is the base value.
    mov    dx, ax
    and    dx, 0xFF
    ; - Isolate the highest 8-bit portion of the rotated private key, which is a mask to be
    ;   applied to the base value.
    shr    ax, 8
    ; - Flip set bits in the base value that are also set in the mask.
    xor    ax, dx
    ; - Flip all bits in the result.
    not    ax
    ret

decrypt_message:
    ; This function takes one 16-bit integer as argument.
    ; The SI register is used to preserve values instead of using the stack since
    ; it is known that SI is not used in the other functions.
    mov  si, di
    ; It returns a 16-bit integer, of which:
    ; - The higher 8 bits are the formatted private key, according to 'format_private_key'
    call format_private_key
    shl  ax, 8            ; Move to upper 8 bits
    mov  di, si           ; Restore original input
    mov  si, ax           ; Preserve higher 8 bits of return value
    ; - The lower 8 bits are the message with all bits set, according to 'set_message_bits'
    call set_message_bits
    and  ax, 0xFF         ; Clear any residual bits in AH
    or   ax, si           ; Apply higher 8 bits from format_private_key
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
