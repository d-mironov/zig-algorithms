const std = @import("std");
const print = std.debug.print;
const rng = std.rand.DefaultPrng;

fn swap(a: *i32, b: *i32) void {
    const tmp = a.*;
    a.* = b.*;
    b.* = tmp;
}

pub fn print_arr(arr: []i32) void {
    for (arr) |e| {
        print("| {d} ", .{e});
    }
    print("|\n", .{});
}

pub fn bubble(arr: []i32) void {
    var step: u32 = 0;
    while (step < arr.len) : (step += 1) {
        var i: u32 = 0;
        while (i < arr.len - step - 1) : (i += 1) {
            if (arr[i] > arr[i + 1]) {
                swap(&arr[i], &arr[i + 1]);
            }
        }
    }
}

pub fn bubble_sort_optimized(arr: []i32) void {
    var step: u32 = 0;
    while (step < arr.len) : (step += 1) {
        var swapped: bool = false;
        var i: usize = 0;
        while (i < arr.len - step - 1) : (i += 1) {
            swap(&arr[i], &arr[i + 1]);
            swapped = true;
        }
        if (swapped == false) {
            break;
        }
    }
}

pub fn selection(arr: []i32) void {
    var step: u32 = 0;
    while (step < arr.len) : (step += 1) {
        var min_index = step;
        var i = step + 1;
        while (i < arr.len) : (i += 1) {
            if (arr[i] < arr[min_index]) {
                min_index = i;
            }
        }
        swap(&arr[min_index], &arr[step]);
    }
}

pub fn insertion(arr: []i32) void {
    var step: u32 = 1;
    while (step < arr.len) : (step += 1) {
        var k = arr[step];
        var i: u32 = step - 1;
        while (k < arr[i] and i > 0) : (i -= 1) {
            print("{d}\n", .{i});
            arr[i + 1] = arr[i];
        }
        arr[i + 1] = k;
    }
}

pub fn partition(arr: []i32, left: i32, right: i32) i32 {
    var low = @intCast(u32, left);
    var high = @intCast(u32, right);
    var pivot = arr[low];

    if (arr.len == 0) {
        return 0;
    }
    while (low < high) {
        while (arr[low] < pivot) {
            low += 1;
        }
        while (arr[high] > pivot) {
            high -= 1;
        }
        if (arr[low] == arr[high]) {
            return @intCast(i32, low);
        }
        if (low < high) {
            swap(&arr[low], &arr[high]);
        }
    }
    return @intCast(i32, low);
}

pub fn quicksort_recursive(arr: []i32, left: i32, right: i32) void {
    if (left < right) {
        var pivot = partition(arr, left, right);
        quicksort_recursive(arr, left, pivot - 1);
        quicksort_recursive(arr, pivot + 1, right);
    }
}

pub fn quicksort(arr: []i32) void {
    quicksort_recursive(arr, 0, @intCast(i32, (arr.len - 1)));
}
