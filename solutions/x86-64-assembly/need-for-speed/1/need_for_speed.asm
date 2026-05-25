default rel

; The functions below make use of the following structs and enum:
;
; struct car_t {
;    char name[10];
;    int16_t speed;
;    float battery;
; };
;
; enum surface_t {
;    ASPHALT,
;    SAND,
;    ICE,
;    CLAY
; };
;
; struct track_t {
;    enum surface_t surface;
;    size_t distance;
; };
;
; struct race_t {
;    struct track_t track;
;    uint8_t num_of_laps;
;    struct car_t cars[6];
;    uint8_t num_of_running_cars;
; };
;
; struct tournament_t {
;    struct race_t races[20];
;    size_t num_of_races;
; };

RACE_QWORD_SIZE  equ 15         ; Size of race_t in 8-byte blocks
RACE_BYTE_SIZE   equ 15 * 8     ; Size of race_t in bytes
TOURNAMENT_LIMIT equ 20         ; Maximum number of races a tournament can have

section .rodata

default_battery dd 100.0

section .text

global new_car
global new_track
global new_race
global add_participant
global add_race

; struct car_t new_car(short speed, const char name[]);
new_car:
    ; This returns a new struct car_t with the values provided.
    ; The starting value for field 'battery' is 100.0.
    mov   rax, [rsi]         ; Copy first 8 bytes of name
    xor   edx, edx           ; Clear RDX to receive data
    mov   dx, word [rsi + 8] ; Copy last two bytes of name
    movss xmm0, dword [default_battery]
    movd  ecx, xmm0          ; Get battery amount into a GPR
    shl   rcx, 32            ; Move value to upper 4 bytes
    movzx rdi, di            ; Zero extend speed
    shl   rdi, 16            ; Move to relative expected byte location
    or    rdi, rcx           ; Combine battery and speed data
    or    rdx, rdi           ; Add them to existing last two bytes of name
    ret

; struct track_t new_track(enum surface_t surface, size_t distance);
new_track:
    ; This returns a new struct track_t with the values provided.
    mov   rax, rdi
    mov   rdx, rsi
    ret

; struct race_t new_race(struct track_t track, uint8_t num_of_laps);
new_race:
    ; This returns a new struct race_t with the values provided.
    ; The starting number of running cars is 0.

    ; The new_track function is called to create the track parameter, so the 16
    ; bytes of data for the track are located in the RAX and RDX registers.
    mov   qword [rdi + 0], rax
    mov   qword [rdi + 8], rdx

    ; With 4-byte alignment, the next 8 bytes store the one byte for num_of_laps
    ; with 3 bytes of padding and 4 bytes to begin storing the first car.
    movzx rcx, cl         ; num_of_laps + 4 bytes of first car's name cleared
    mov   qword [rdi + 16], rcx
    add   rdi, 24         ; Offset to finish storing the first car

    ; At this point, there are 6 bytes left for the first car's name field to
    ; store. The rest of the name field and the speed field fill the next 8-byte
    ; boundary. The battery and first 4 bytes of the next car's name field fill
    ; the next 8-byte boundary. This continues through the rest of the cars with
    ; the last 4 bytes after the last car's battery field being used for the one
    ; byte number of running cars to race, leaving the last 3 bytes as padding.
    ;
    mov   ecx, 12         ; Total number of 8-byte boundaries to clear
    xor   eax, eax        ; The zeros to clear them with
    rep   stosq
    ret

; bool add_participant(struct race_t *race, struct car_t car);
add_participant:
    ; If there's room for one more participant in the race, the car will be
    ; added to the list, updating the counter, and its participation is
    ; confirmed. Otherwise, the race organizers must inform the car's owner that
    ; it can't participate this time.
    ;
    ; Tests call new_car function, putting second parameter into RAX and RDX.
    add   rdi, 20         ; Offset to first byte of cars
    mov   sil, byte [rdi] ; Get first byte of first car's name field
    test  sil, sil        ; Check if it is a NUL byte
    jz    .copy_car       ; If so, copy the input car into the first spot
    mov   ecx, 5          ; Car spots remaining in race

.next_car:
    add   rdi, 16         ; Advance to next car offset
    test  ecx, ecx        ; Are there more cars to visit?
    jz    .race_full      ; If not, notify owner that there is no availability
    dec   ecx             ; Otherwise, decrement car count
    mov   sil, byte [rdi] ; Check the current car's name field
    test  sil, sil        ; Check if it is a NUL byte
    jnz   .next_car       ; If not, check the next spot

.copy_car:
    stosq                 ; Copy RAX part of car
    mov   rax, rdx
    stosq                 ; Copy RDX part of car
    mov   rax, 1          ; Participant added
    ret

.race_full:
    xor   rax, rax        ; Participant not added
    ret

; void add_race(struct tournament_t *tournament, struct race_t race);
add_race:
    ; This adds a race to the tournament's array and also updates its counter.
    lea   r8, [rdi + TOURNAMENT_LIMIT * RACE_BYTE_SIZE]
    mov   r9, qword [r8]         ; Read the value of num_of_races
    cmp   r9, TOURNAMENT_LIMIT   ; Is the tournament full?
    je    .done                  ; If so, there is nothing to do

    imul  r9, r9, RACE_BYTE_SIZE ; Otherwise, calculate offset for next race
    add   rdi, r9                ; Apply offset for destination
    mov   rsi, rax               ; Copy input race address to source register
    mov   rcx, RACE_QWORD_SIZE   ; Number of qwords in a race
    rep   movsq                  ; Store input race as a new entry in tournament
    inc   qword [r8]             ; Update tournament's race count

.done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
