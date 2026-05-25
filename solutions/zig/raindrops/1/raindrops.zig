const std = @import("std");

pub fn convert(buffer: []u8, n: u32) []const u8 {
    const sounds = getSounds(buffer, n);

    if (sounds.len > 0) return sounds;

    return std.fmt.bufPrint(buffer, "{d}", .{n}) catch unreachable;
}

fn getSounds(buffer: []u8, n: u32) []const u8 {
    return std.fmt.bufPrint(
        buffer,
        "{s}{s}{s}",
        .{
            if (n % 3 == 0) "Pling" else "",
            if (n % 5 == 0) "Plang" else "",
            if (n % 7 == 0) "Plong" else ""
        }) catch unreachable;
}
