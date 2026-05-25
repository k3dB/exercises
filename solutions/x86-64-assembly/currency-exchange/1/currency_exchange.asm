default rel

FLOOR equ 1               ; Floor rounding flag-set value

section .rodata

one_percent dq 0.01

; Based on the enum currency_t
currency_names:
    db "GBP", 0
    db "EUR", 0
    db "JPY", 0
    db "AUD", 0
    db "BRL", 0
    db "CNY", 0
    db "CAD", 0
    db "INR", 0

section .text

global stringify_currency
global exchange_rate
global get_value_of_bills
global get_number_of_bills
global exchangeable_value

stringify_currency:
    ; This function has signature:
    ; void stringify_currency(char *buffer, enum currency_t currency);
    ; It stores the string representation for the value of a enum currency_t in
    ; the passed buffer.
    shl   rsi, 2                ; Convert index to offset
    lea   rax, [currency_names] ; Get base address of currency names
    lea   rsi, [rax + rsi]      ; Apply offset for source
    mov   rcx, 4                ; All values are 4 bytes (including NUL byte)
    rep   movsb
    ret

exchange_rate:
    ; This function has signature:
    ; double exchange_rate(
    ;     enum currency_t domestic_currency,
    ;     enum currency_t foreign_currency,
    ;     const double *value_in_US_dollars);
    ; It returns the value of one unit of foreign currency in the domestic
    ; currency.
    ; `value_in_US_dollars` is a pointer to the beginning of an array of
    ; `double` with the value of 1 unit of each enum currency_t, in dollars.
    shl   rdi, 3          ; Convert both indexes to offsets (8-byte doubles)
    shl   rsi, 3
    movsd xmm0, qword [rdx + rsi] ; Foreign
    movsd xmm1, qword [rdx + rdi] ; Domestic
    divsd xmm0, xmm1      ; Divide foreign by domestic to get rate to return
    ret

get_value_of_bills:
    ; This function has signature:
    ; uint64_t get_value_of_bills(
    ;     unsigned long long denomination,
    ;     unsigned short number_of_bills);
    ; It returns the total value of the bills.
    mov   rax, rdi        ; Simply multiply the two inputs
    mul   rsi
    ret

get_number_of_bills:
    ; This function has signature:
    ; unsigned int get_number_of_bills(
    ;     float amount,
    ;     unsigned long long denomination);
    ; It returns the nuumber of whole bills that can be received within the
    ; given amount.
    cvtsi2ss xmm1, rdi          ; Get everything in floating point land
    divss    xmm0, xmm1         ; Divide the amount by the denomination
    roundss  xmm0, xmm0, FLOOR  ; Denominations are whole bills
    cvtss2si rax, xmm0          ; Convert back to integer to return
    ret

exchangeable_value:
    ; This function has signature:
    ; uint32_t exchangeable_value(
    ;     float budget,
    ;     double exchange_rate,
    ;     uint8_t spread,
    ;     unsigned long long denomination);
    ; It returns the maximum value of the new currency after calculating the
    ; exchange rate adjusted by the spread.
    cvtsi2sd xmm2, rdi    ; Convert integers to doubles
    cvtsi2sd xmm3, rsi
    movsd    xmm4, qword [one_percent]
    mulsd    xmm2, xmm4   ; Get percentage
    mov      rax, 1
    cvtsi2sd xmm4, rax
    addsd    xmm2, xmm4   ; Add one to increase via mulitplication
    mulsd    xmm1, xmm2   ; Full exchange rate including spread
    cvtss2sd xmm0, xmm0   ; Convert budget to double
    divsd    xmm0, xmm1   ; Full currency conversion amount
    divsd    xmm0, xmm3   ; Divide by denomination then remove fractional part
    roundsd  xmm0, xmm0, FLOOR
    mulsd    xmm0, xmm3   ; Multiply floored value by denomination
    cvtsd2si rax, xmm0    ; Convert to integer to return
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
