const std = @import("std");

pub fn isIsogram(str: []const u8) bool {
    var letters = std.AutoHashMap(u8, void).init(std.heap.page_allocator);
    defer letters.deinit();

    var buffer: [1024]u8 = undefined;
    const lower = std.ascii.lowerString(&buffer, str);

    for (lower) |character| {
        if (character == ' ' or character == '-') {
            continue;
        }

        if (letters.contains(character)) {
            return false;
        }

        _ = letters.getOrPut(character) catch {
            return false;
        };
    }

    return true;
}
