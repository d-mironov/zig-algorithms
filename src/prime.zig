const std = @import("std");
const print = std.debug.print;
const HashMap = std.AutoHashMap;

pub fn sieve_of_erathostenes_arr(n: u32, verbose: bool) !void {
    var allocator = std.heap.page_allocator;
    var sieve = try allocator.alloc(bool, n + 1);
    for (sieve) |_, index| {
        sieve[index] = true;
    }
    sieve[0] = false;
    sieve[1] = false;

    var i: u32 = 2;
    while (i * i < n) : (i += 1) {
        if (sieve[i] == true) {
            var j: u32 = i * i;
            while (j <= n) : (j += i) {
                sieve[j] = false;
            }
        }
    }
    if (verbose == true) {
        for (sieve) |e, k| {
            if (e == true) {
                print("{d}\n", .{k});
            }
        }
    }
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
    while (i * i <= n) : (i += 1) {
        if (sieve.get(i) == true) {
            var j: u32 = i * i;
            while (j <= n) : (j += i) {
                try sieve.put(j, false);
            }
        }
    }
    if (verbose == true) {
        var iterator = sieve.iterator();
        i = 0;
        while (iterator.next()) |entry| {
            if (entry.value_ptr.* == true) {
                print("{d}\n", .{entry.key_ptr.*});
            }
        }
    }
}
