const std = @import("std");
const print = std.debug.print;

pub fn faculty(n: u32) u32 {
    if (n == 0 or n == 1) {
        return 1;
    }
    return n * faculty(n - 1);
}
