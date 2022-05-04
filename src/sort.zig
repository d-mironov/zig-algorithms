const std = @import("std");
const print = std.debug.print;
const rng = std.rand.DefaultPrng;

/// Swap function
///
/// Swap two variables by their values
///
/// Arguments:
/// > `a`, `b`: Variables to swap
///
/// Return:
/// > `void`
/// > 
fn swap(a: *i32, b: *i32) void {
    const tmp = a.*;
    a.* = b.*;
    b.* = tmp;
}

/// Print the specified array 
/// in the form:
/// > `| x0 | x1 | ... | xn |`
///
/// Arguments:
/// > `arr`: Array to print
///
pub fn print_arr(arr: []i32) void {
    for (arr) |e| {
        print("| {d} ", .{e});
    }
    print("|\n", .{});
}

/// # BubbleSort
/// ------
/// Description:
/// Perform the bubble sort algorithm on an `i32` array
/// ------
/// Arguments:
/// > `arr`: `i32` array to perform BubbleSort on
/// ------
/// TODO: 
/// > [] add descending option
/// ------
///
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

/// # BubbleSort Optimized
/// ------
/// Description:
/// Perform the bubble sort algorithm on an `i32` array.
/// This is an optimized version.
/// ------
/// Arguments:
/// > `arr`: `i32` array to perform BubbleSort on
/// ------
/// TODO: 
/// > [] add descending option
/// ------
///
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

/// # SelectionSort
/// ------
/// Description:
/// Perform the SelectionSort algorithm on an `i32` array.
/// ------
/// Arguments:
/// > `arr`: `i32` array to perform SelectionSort on
/// ------
/// TODO: 
/// > [] add descending option
/// ------
///
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

/// # QuickSort Partition helper
/// -------------------------------------------------------------------------
/// this function helps partitioning the array 
/// to have the smallest numbers on the left and the 
/// greatest numbers on the right side, all depending on 
/// a **pivot** point.
/// Pivot can either be just the first element in the array,
/// or be selected random from the array by setting `randomize` to `true`.
/// -------------------------------------------------------------------------
/// Arguments:
/// > `arr`: Array to partition
/// > `left`: lower end where to start partitioning
/// > `right`: upper end where to end partitioning
/// > `randomize`: randomized pivot select if `true`, else first element from 
/// list
/// -------------------------------------------------------------------------
/// Return:
/// > `i32`: position of the pivot point -> useful for further partitioning.
///
pub fn partition(arr: []i32, left: i32, right: i32, randomize: bool) i32 {
    var low = @intCast(u32, left);
    var high = @intCast(u32, right);

    var rnd = rng.init(0);
    var pivot = arr[if (randomize == true) rnd.random().intRangeAtMost(u32, low, high) else low];

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

/// # QuickSort Recursive
/// -------------------------------------------------------------------------
/// Description:
/// Sorts the array with QuickSort from lower(`left`) to upper(`right`) limit.
/// -------------------------------------------------------------------------
/// Arguments:
/// > `arr`: Array to sort
/// > `left`: lower end where to start sorting
/// > `right`: upper end where to end sorting
/// > `randomize`: randomized pivot select if `true`, else first element from 
/// list
/// -------------------------------------------------------------------------
/// Return:
/// > `void`
///
pub fn quicksort_recursive(arr: []i32, left: i32, right: i32, randomize: bool) void {
    if (left < right) {
        var pivot = partition(arr, left, right, randomize);
        quicksort_recursive(arr, left, pivot - 1, randomize);
        quicksort_recursive(arr, pivot + 1, right, randomize);
    }
}

/// # QuickSort
/// -------------------------------------------------------------------------
/// Description:
/// Sorts the array using the QuickSort algorithm. You can select 
/// randomized **pivot** point by setting the `random_piv` argument to `true`
/// -------------------------------------------------------------------------
/// Arguments:
/// > `arr`: Array to sort
/// > `rand_piv`: randomized pivot select if `true`, else first element from 
/// list
/// -------------------------------------------------------------------------
/// Return:
/// > `void`
///
pub fn quicksort(arr: []i32, random_piv: bool) void {
    if (arr.len < 1) {
        return;
    }
    quicksort_recursive(arr, 0, @intCast(i32, (arr.len - 1)), random_piv);
}
