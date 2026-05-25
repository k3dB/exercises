.section .rodata

question:        .string "Sure."
yelled_question: .string "Calm down, I know what I'm doing!"
yell:            .string "Whoa, chill out!"
silence:         .string "Fine. Be that way!"
statement:       .string "Whatever."

// Flags
// 0 0 0 0  1 1 1 1
//    1 ->  | | | Non-white-space found (not silence)
//    2 ->  | | Lower letter found
//    4 ->  | Upper case letter found
//    8 ->  Last non-white-space is question mark

set_not_silence_mask = 1
set_lower_mask       = 2
set_capital_mask     = 4
set_question_mask    = 8

yelled_question_mask = 0x0D
yelled_mask          = 0x05

clear_question_mask  = 0x07

.text
.globl response

response:
    mov   w2, wzr               // Clear all flags
    mov   w4, #1                // Hold one in a register

_next_byte:
    ldrb  w1, [x0], #1          // Get current byte and increment input address
    cmp   w1, #0                // Finished scanning input?
    beq   _respond

    cmp   w1, #' '              // Ignore spaces
    beq   _next_byte
    cmp   w1, #'\t'             // Ignore tabs
    beq   _next_byte
    cmp   w1, #'\r'             // Ignore carriage returns
    beq   _next_byte
    cmp   w1, #'\n'             // Ignore line feeds
    beq   _next_byte

    orr   w2, w2, #set_not_silence_mask

    cmp   w1, #'?'
    beq   _handle_question_mark

    and   w2, w2, #clear_question_mask

    cmp   w1, #'A'              // Check for a capital letter
    csel  w3, w4, wzr, ge
    cmp   w1, #'Z'
    csel  w5, w4, wzr, le
    and   w3, w3, w5
    mov   w5, #set_capital_mask
    cmp   w3, #1
    csel  w3, w5, wzr, eq       // Set capital letter flag, if found
    orr   w2, w2, w3

    cmp   w1, #'a'              // Check for a lower case letter
    csel  w3, w4, wzr, ge
    cmp   w1, #'z'
    csel  w5, w4, wzr, le
    and   w3, w3, w5
    mov   w5, #set_lower_mask
    cmp   w3, #1
    csel  w3, w5, wzr, eq       // Set lower case letter flag if found
    orr   w2, w2, w3

    b     _next_byte

_handle_question_mark:
    orr   w2, w2, #set_question_mask
    b     _next_byte

_respond:
    tst   w2, #set_not_silence_mask
    beq   _silence

    cmp   w2, #yelled_question_mask
    beq   _yelled_question

    cmp   w2, #yelled_mask
    beq   _yell

    tst   w2, #set_question_mask
    bne   _question

    adr   x0, statement
    ret

_yelled_question:
    adr   x0, yelled_question
    ret

_question:
    adr   x0, question
    ret

_yell:
    adr   x0, yell
    ret

_silence:
    adr   x0, silence
    ret
