const std = @import("std");
const fac = @import("faculty.zig");
const sort = @import("sort.zig");
const search = @import("search.zig");
const print = std.debug.print;

pub fn main() anyerror!void {
    var arr1 = [_]i32{ 5, 4, 3, 2, 1 };
    var arr2 = [_]i32{ 5, 4, 3, 2, 1 };
    var arr3 = [_]i32{ 5, 4, 3, 2, 1 };

    sort.bubble(&arr1);
    sort.print_arr(&arr1);

    sort.bubble_sort_optimized(&arr2);
    sort.print_arr(&arr2);

    sort.selection(&arr3);
    sort.print_arr(&arr3);

    var arr4 = [_]i32{ 1, 2, 3, 4, 5, 6, 7, 8 };
    print("arr search 2: {d}\n", .{try search.binary(&arr4, 2)});
    print("arr search 7: {d}\n", .{try search.binary(&arr4, 7)});
    print("arr linear search 7: {d}\n", .{try search.linear(&arr4, 7)});
    //print("arr linear search 10: {d}\n", .{try search.linear(&arr4, 10)});
}
