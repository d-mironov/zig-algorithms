const std = @import("std");
const fac = @import("faculty.zig");
const print = std.debug.print;

pub fn main() anyerror!void {
    print("faculty(1): {d}\n", .{fac.faculty(1)});
    print("faculty(2): {d}\n", .{fac.faculty(2)});
    print("faculty(3): {d}\n", .{fac.faculty(3)});
    print("faculty(4): {d}\n", .{fac.faculty(4)});
    print("faculty(5): {d}\n", .{fac.faculty(5)});
}
