const std = @import("std");
const print = std.debug.print;

const SearchError = error{
    ElementNotFound,
};

/// Binary Search
///
/// Search a sorted `i32` array for element `n`
/// 
/// Parameters:
/// `arr` - Array to search
/// `n` - Element to serach
///
/// Return:
/// Index of element when found, `ElementNotFound` error if not.
pub fn binary(arr: []i32, n: i32) SearchError!i32 {
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
    return SearchError.ElementNotFound;
}

/// Linear Search
///
/// Search an `i32` array for element `n`
/// 
/// Parameters:
/// `arr` - Array to search
/// `n` - Element to serach
///
/// Return:
/// Index of element when found, `ElementNotFound` error if not.
pub fn linear(arr: []i32, n: i32) SearchError!i32 {
    for (arr) |e, i| {
        if (e == n) {
            return @intCast(i32, i);
        }
    }
    return SearchError.ElementNotFound;
}
