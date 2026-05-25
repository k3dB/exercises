.text
.globl to_rna

to_rna:
.next:
    ldrb  w2, [x1], #1          // Get next input byte
    cbz   w2, .return           // Are we done?
    cmp   w2, #'C'              // Check each DNA nucleotide
    beq   .cytosine
    cmp   w2, #'G'
    beq   .guanine
    cmp   w2, #'T'
    beq   .thymine
    cmp   w2, #'A'
    beq   .adenine
    b     .next                 // Skip invalid bytes

.cytosine:
    mov   w2, #'G'              // Transcribe cytosine to guanine
    strb  w2, [x0], #1
    b     .next

.guanine:
    mov   w2, #'C'              // Transcribe guanine to cytosine
    strb  w2, [x0], #1
    b     .next

.thymine:
    mov   w2, #'A'              // Transcribe thymine to adenine
    strb  w2, [x0], #1
    b     .next

.adenine:
    mov   w2, #'U'              // Transcribe adenine to uracil
    strb  w2, [x0], #1
    b     .next

.return:
    strb  wzr, [x0]             // Null-terminate output buffer
    ret
