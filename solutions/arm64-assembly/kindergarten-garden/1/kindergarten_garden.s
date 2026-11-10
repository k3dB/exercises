.section .rodata

grass:    .asciz "grass"
clover:   .asciz "clover"
radishes: .asciz "radishes"
violets:  .asciz "violets"

separator: .asciz ", "

.text
.globl plants

// extern void plants(char *buffer, const char *diagram, const char *student);
plants:
    stp     x29, x30, [sp, #-16]! // prologue

    // Due to the convenient names of the students, we only care about the first
    // letter of the student's name.
    ldrb    w3, [x2]              // convert first letter of student's name to
    sub     w3, w3, #'A'          // the offset of their first cup on each row
    lsl     x3, x3, #1

    add     x1, x1, x3            // address of students first cup on first row
    ldrb    w5, [x1], #1          // first cup
    ldrb    w6, [x1], #1          // second cup

.next_cup:
    ldrb    w7, [x1], #1          // find next row starting index
    cmp     w7, #'\n'
    bne     .next_cup

    add     x1, x1, x3            // address of students first cup on second row
    ldrb    w7, [x1], #1          // third cup
    ldrb    w8, [x1], #1          // fourth cup

    mov     x1, x5                // record first plant
    mov     x2, #0                // is last plant? (flag parameter)
    bl      record_plant
    mov     x1, x6                // record second plant
    bl      record_plant
    mov     x1, x7                // record third plant
    bl      record_plant
    mov     x1, x8                // record fourth plant
    mov     x2, #1                // is last plant? (flag parameter)
    bl      record_plant

    ldp     x29, x30, [sp], #16   // epilogue
    ret

// x0 = buffer pointer
// x1 = letter for plant from the diagram
// x2 = flag to determine if we append the separator
// x5 - x8 are not clobbered,
//    so caller does not need to use non-volatile registers
record_plant:
    cmp     w1, #'G'              // select which plant type to record
    beq     .grass

    cmp     w1, #'C'
    beq     .clover

    cmp     w1, #'R'
    beq     .radishes

    cmp     w1, #'V'
    beq     .violets

    ret                           // skip invalid plant type

.grass:
    adrp    x3, grass             // load appropriate address for plant type
    add     x3, x3, :lo12:grass
    b       .record

.clover:
    adrp    x3, clover
    add     x3, x3, :lo12:clover
    b       .record

.radishes:
    adrp    x3, radishes
    add     x3, x3, :lo12:radishes
    b       .record

.violets:
    adrp    x3, violets
    add     x3, x3, :lo12:violets
    b       .record

.record:
    ldrb    w4, [x3], #1          // record the plant name
    strb    w4, [x0], #1
    cbnz    w4, .record

    cbz     x2, .use_separator    // append seporator if flag is not set
    ret                           // otherwise, keep null-terminator and return

.use_separator:
    sub     x0, x0, #1            // back out of null-terminator for separator
    adrp    x3, separator
    add     x3, x3, :lo12:separator

.next_separator_byte:
    ldrb    w4, [x3], #1
    strb    w4, [x0], #1
    cbnz    w4, .next_separator_byte

    sub     x0, x0, #1            // back out of null-terminator for next plant
    ret
