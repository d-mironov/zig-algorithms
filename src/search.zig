const std = @import("std");
const print = std.debug.print;

pub fn binary_search(arr: []i32, n: i32) i32 {
    var upper: u32 = @intCast(u32, arr.len);
    var lower: u32 = 0;
    while (upper > lower) {
        var mid: u32 = lower + @divTrunc(upper - lower, 2);
        if (arr[mid] == n) {
            return @intCast(i32, mid);
        }
        if (arr[mid] > n) {
            upper = mid - 1;
        } else {
            lower = mid + 1;
        }
    }
    return -1;
}
