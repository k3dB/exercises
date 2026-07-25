.text
.globl find_anagrams

// void find_anagrams(
//     int        *is_anagram,    // Map each candidate to anagram result
//     const char *candidates[],  // The candidates to test
//     size_t     num_candidates, // The number of candidates
//     const char *subject)       // Test if candidate is an anagram of subject
find_anagrams:
    sub   sp, sp, #32           // Reserve stack space for letter counts
    mov   x4, xzr               // Candidate index

.next_candidate:
    cmp   x4, x2                // Finished checking all candidates?
    beq   .done

    stp   xzr, xzr, [sp]        // Clear first 16 letter counts
    stp   xzr, xzr, [sp, #16]   // Clear the rest (and padding)

    ldr   x5, [x1, x4, lsl #3]  // Get address of current candidate
    mov   x6, xzr               // Subject/candidate letter index
    mov   x7, #1                // Set = same word; Clear = not same word

.next_letter:
    ldrb  w8, [x3, x6]          // Current subject letter
    cbz   w8, .check_anagram    // More letters in subject?
    ldrb  w9, [x5, x6]          // Current candidate letter
    cbz   w9, .prepare_next     // Candidate is too short?
    add   x6, x6, #1            // Prepare for next letter

    orr   w8, w8, #32           // Convert both letters to lowercase
    orr   w9, w9, #32
    sub   w8, w8, 'a'           // Convert to index (offset from stack pointer)
    sub   w9, w9, 'a'

    cmp   w8, w9                // Are the letters the same?
    beq   .next_letter          // No need to count, still a candidate
    mov   x7, xzr               // Reached a different letter, not the same word

    ldrb  w10, [sp, x8]         // Get current subject letter count
    add   w10, w10, #1          // Increment subject letter count
    strb  w10, [sp, x8]         // Store updated subject letter count

    ldrb  w10, [sp, x9]         // Get current candidate letter count
    sub   w10, w10, #1          // Decrememt candidate letter count
    strb  w10, [sp, x9]         // Store updated candidate letter count
    b     .next_letter

.check_anagram:
    ldrb  w9, [x5, x6]          // Current candidate letter
    cbnz  w9, .prepare_next     // Candidate is longer than subject?
    cbnz  x7, .prepare_next     // Same word is not an anagram

    ldp   x8,  x9,  [sp]        // Get first 16 letter counts
    ldp   x10, x11, [sp, #16]   // Get the rest (and padding)

    cbnz  x8,  .prepare_next    // If any letter count is not zero,
    cbnz  x9,  .prepare_next    // then it is not an anagram
    cbnz  x10, .prepare_next
    cbnz  x11, .prepare_next

    mov   x8, #1                // If we reach this point, it is an anagram
    str   w8, [x0, x4, lsl #2]

.prepare_next:
    add   x4, x4, #1            // Next candidate index
    b     .next_candidate

.done:
    add   sp, sp, #32           // Restore stack pointer
    ret
