const std = @import("std");
const fac = @import("faculty.zig");
const bubble = @import("bubble_sort.zig");
const print = std.debug.print;

pub fn main() anyerror!void {
    var arr1 = [_]i32{ 5, 4, 3, 2, 1 };

    bubble.bubble_sort(&arr1);

    for (arr1) |e| {
        print("{d}\n", .{e});
    }
}
