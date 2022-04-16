const std = @import("std");
const print = std.debug.print;

fn swap(a: *i32, b: *i32) void {
    const tmp = a.*;
    a.* = b.*;
    b.* = tmp;
}

pub fn bubble_sort(arr: []i32) void {
    var step: u32 = 0;
    while (step < arr.len - 1) : (step += 1) {
        var i: u32 = 0;
        while (i < arr.len - step - 1) : (i += 1) {
            if (arr[i] > arr[i + 1]) {
                swap(&arr[i], &arr[i + 1]);
            }
        }
    }
}
