const std = @import("std");
const fac = @import("faculty.zig");
const sorting = @import("sorting.zig");
const print = std.debug.print;

pub fn main() anyerror!void {
    var arr1 = [_]i32{ 5, 4, 3, 2, 1 };
    var arr2 = [_]i32{ 5, 4, 3, 2, 1 };
    var arr3 = [_]i32{ 5, 4, 3, 2, 1 };

    sorting.bubble_sort(&arr1);
    sorting.print_arr(&arr1);

    sorting.bubble_sort_optimized(&arr2);
    sorting.print_arr(&arr2);

    sorting.selection_sort(&arr3);
    sorting.print_arr(&arr3);
}
