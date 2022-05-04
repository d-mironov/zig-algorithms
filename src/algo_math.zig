const std = @import("std");
const print = std.debug.print;
const HashMap = std.AutoHashMap;
const time = std.time;
// const c = @cImport({
//     @cInclude("time.h");
// });

pub fn sieve_of_erathostenes_arr(n: u64, verbose: bool) !void {
    var allocator = std.heap.page_allocator;
    var sieve = try allocator.alloc(bool, n + 1);
    defer allocator.free(sieve);
    for (sieve) |_, index| {
        sieve[index] = true;
    }
    sieve[0] = false;
    sieve[1] = false;
    var i: u64 = 2;
    // var start = c.clock();
    var start = time.milliTimestamp();
    while (i * i < n) : (i += 1) {
        if (sieve[i] == true) {
            var j: u64 = i * i;
            while (j <= n) : (j += i) {
                sieve[j] = false;
            }
        }
    }
    var msec = time.milliTimestamp() - start;
    // var diff = c.clock() - start;
    // var msec = @divFloor(diff * 1000, c.CLOCKS_PER_SEC);
    if (verbose == true) {
        i = 1;
        for (sieve) |e, k| {
            if (e == true) {
                print("\t{d:8}", .{k});
                i += 1;
                if (i % 8 == 0) {
                    print("\n", .{});
                }
            }
        }
    }
    print("\n\n[+] prime sieve took {d} milliseconds\n", .{msec});
}

pub fn sieve_of_erathostenes_hash(n: u32, verbose: bool) !void {
    var allocator = std.heap.page_allocator;
    var sieve = HashMap(u32, bool).init(allocator);
    defer sieve.deinit();
    var i: u32 = 0;
    while (i <= n) : (i += 1) {
        try sieve.put(i, true);
    }
    try sieve.put(0, false);
    try sieve.put(1, false);

    i = 2;
    var start = time.milliTimestamp();
    while (i * i <= n) : (i += 1) {
        if (sieve.get(i) == true) {
            var j: u32 = i * i;
            while (j <= n) : (j += i) {
                try sieve.put(j, false);
            }
        }
    }
    var msec = time.milliTimestamp() - start;
    if (verbose == true) {
        var iterator = sieve.iterator();
        i = 0;
        while (iterator.next()) |entry| {
            if (entry.value_ptr.* == true) {
                print("{d}\n", .{entry.key_ptr.*});
            }
        }
    }
    print("\n\n[+] prime sieve took {d} milliseconds\n", .{msec});
}

pub fn fibonacci(n: u32) u32 {
    if (n == 0 or n == 1) {
        return 1;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

pub fn fibonacci_oneline(n: u32) u32 {
    return if (n == 0 or n == 1) 1 else fibonacci_oneline(n - 1) + fibonacci_oneline(n - 2);
}

pub fn euclidian_greatest_common_divisor(a: u32, b: u32) u32 {
    return if (b == 0) a else euclidian_greatest_common_divisor(b, a % b);
}

pub fn faculty(n: u32) u32 {
    if (n == 0 or n == 1) {
        return 1;
    }
    return n * faculty(n - 1);
}

pub fn faculty_oneline(n: u32) u32 {
    return if (n == 0 or n == 1) 1 else n * faculty_oneline(n - 1);
}
