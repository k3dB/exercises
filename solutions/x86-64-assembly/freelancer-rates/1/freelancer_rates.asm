CEIL equ 2                    ; Ceiling rounding flag
FLOOR equ 1                   ; Floor rounding flag
HOURS_PER_DAY equ 8
HOURS_PER_MONTH equ 8 * 22    ; Billable hours * billable days
PERCENT_DIVISOR equ 100

section .text

global daily_rate
global apply_discount
global monthly_rate
global days_in_budget

daily_rate:
    ; This function takes an hourly rate, as a 64-bit floating-point number.
    ; It returns the daily rate, also as a 64-bit floating-point number.
    ; A day has 8 billable hours.
    mov      rax, HOURS_PER_DAY
    cvtsi2sd xmm1, rax
    mulsd    xmm0, xmm1
    ret

apply_discount:
    ; This function takes as parameters a price and a discount in percent,
    ; both as 64-bit floating-point number.
    ; It returns the price with discount applied,
    ; as a 64-bit floating-point number.
    mov      rax, PERCENT_DIVISOR
    cvtsi2sd xmm2, rax
    divsd    xmm1, xmm2   ; Convert percent to a decimal value
    mulsd    xmm1, xmm0   ; The amount of the discount
    subsd    xmm0, xmm1   ; Apply discount amount to price
    ret

monthly_rate:
    ; This function takes as parameters an hourly rate and a discount in
    ; percent, both as a 64-bit floating-point number.
    ; It returns the discounted monthly rate, as a 64-bit integer, rounded up.
    ; A month has 22 billable days.
    mov      rax, HOURS_PER_MONTH
    mov      rdx, PERCENT_DIVISOR
    cvtsi2sd xmm2, rax    ; Convert both integers to doubles
    cvtsi2sd xmm3, rdx
    divsd    xmm1, xmm3   ; Get percent as decimal
    mulsd    xmm0, xmm2   ; Base monthly rate
    mulsd    xmm1, xmm0   ; Discount for month
    subsd    xmm0, xmm1   ; Apply discount to base monthly rate
    roundsd  xmm0, xmm0, CEIL
    cvtsd2si rax, xmm0    ; Return rounded up value as an integer
    ret

days_in_budget:
    ; This function takes as parameters:
    ; 1. A budget as a 64-bit unsigned integer.
    ; 2. An hourly rate, as a 64-bit floating-point number.
    ; 3. A discount in percent, as a 64-bit floating-point number.
    ; It returns the number of complete days of work the budget covers,
    ; as a 32-bit unsigned integer, rounded down.
    cvtsi2sd xmm2, rdi    ; Budget as double
    mov      rdx, PERCENT_DIVISOR
    cvtsi2sd xmm3, rdx
    divsd    xmm1, xmm3   ; Discount percentage
    mulsd    xmm1, xmm0   ; Discount per hourly rate
    subsd    xmm0, xmm1   ; Discounted hourly rate
    divsd    xmm2, xmm0   ; Budget hours
    mov      rdx, HOURS_PER_DAY
    cvtsi2sd xmm3, rdx
    divsd    xmm2, xmm3   ; Budget days
    roundsd  xmm2, xmm2, FLOOR
    cvtsd2si rax, xmm2    ; Return rounded down budget days
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
