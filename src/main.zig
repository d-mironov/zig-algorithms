const std = @import("std");
const sort = @import("sort.zig");
const search = @import("search.zig");
const math = @import("algo_math.zig");
const print = std.debug.print;

pub fn main() anyerror!void {
    var arr1 = [_]i32{ 76, 1, 35, 75, 56, 7, 8, 96, 54, 53 };
    sort.quicksort(&arr1, true);
    sort.print_arr(&arr1);

    var arr2 = [_]i32{ 5, 5, 5, 5 };
    sort.quicksort(&arr2, true);
    sort.print_arr(&arr2);

    var arr3 = [_]i32{ 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 };
    sort.quicksort(&arr3, true);
    sort.print_arr(&arr3);

    var arr4 = [_]i32{};
    sort.quicksort(&arr4, true);
    sort.print_arr(&arr4);
}
