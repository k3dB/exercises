.text
.equ MAX_ITEMS, 8

.globl allergic_to
.globl list

// extern int allergic_to(item_t item, unsigned int score);
// Determines if item is in score.
allergic_to:
    mov   x2, #1            // A one bit to put in the bit position of the item
    lsl   x2, x2, x0        // Shift the one bit to item position
    and   x0, x2, x1        // Apply bit mask to position to test for item
    ret

// extern void list(unsigned int score, item_list_t *list);
// Populates list based on score.
list:
    mov   x3, xzr           // Count allergens
    and   x0, x0, #0xFF     // Mask off the input bits we do not care about
    cbz   x0, .return       // Return early if there are no allergens

    mov   x2, xzr           // Allergen index
    mov   x4, #1            // A one bit to shift

.next:
    cmp   x2, #MAX_ITEMS    // More allergens?
    beq   .return
    lsl   x5, x4, x2        // Current bit mask
    and   x6, x0, x5        // Check if input has current allergen
    cbnz  x6, .add          // If so, add it to items list
    add   x2, x2, #1        // Prepare next allergen index
    b     .next

.add:
    add   x3, x3, #1        // Count current allergen
    lsl   x6, x3, #2        // 32-bit offset (size element of enum + index)
    str   w2, [x1, x6]      // Store allergen
    add   x2, x2, #1        // Prepare next allergen index
    b     .next

.return:
    str   w3, [x1]          // Store count of allergens (size element of enum)
    ret
