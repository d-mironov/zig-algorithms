const std = @import("std");
const sort = @import("sort.zig");
const search = @import("search.zig");
const math = @import("algo_math.zig");
const print = std.debug.print;
const ds = @import("datastructures.zig");
const Node = ds.Node;
const Stack = ds.Stack;
const list = ds.list;

pub fn main() anyerror!void {
    var ll1 = list(u32).init();

    _ = ll1.push_back(1);
    _ = ll1.push_back(2);
    _ = ll1.push_back(5);
    _ = ll1.push_front(10);
    ll1.show();

    _ = ll1.insert(4, 20);
    ll1.show();
    _ = ll1.insert(6, 20);
    ll1.show();

    _ = ll1.del(4);
    ll1.show();
    _ = ll1.del(4);
    ll1.show();
}
