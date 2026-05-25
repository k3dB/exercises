const std = @import("std");

pub fn isPangram(str: []const u8) bool {
    const letterCount = 26;
    var letterFlags = std.bit_set.IntegerBitSet(letterCount).initEmpty();

    for (str) |character| {
        if (!std.ascii.isAlphabetic(character)) {
            continue;
        }

        letterFlags.set(std.ascii.toLower(character) - 'a');
    }

    return letterCount == letterFlags.count();
}
