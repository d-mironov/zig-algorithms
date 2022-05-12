const std = @import("std");
const sort = @import("sort.zig");
const search = @import("search.zig");
const math = @import("algo_math.zig");
const print = std.debug.print;
const ds = @import("datastructures.zig");
const Node = ds.Node;
const Stack = ds.Stack;

pub fn main() anyerror!void {
    var str1 = "Hello world";
    var n1 = ds.Node(u32).new(10, undefined, undefined);
    var n2 = ds.Node([]const u8).new(str1, undefined, undefined);
    var n3 = ds.Node([]const u8).new("This is nice", undefined, undefined);

    var new_node = try std.heap.page_allocator.create(Node(u32));
    new_node.data = 10;

    print("n1 data: {d}\n", .{n1.get()});
    print("n2 data: {s}\n", .{n2.get()});
    print("n3 data: {s}\n", .{n3.get()});
    print("new_node data: {d}\n", .{new_node.data});

    var stack1 = Stack(u32).init();
    //stack1.head = &n1;
    try stack1.push(50);
    try stack1.push(10);
    try stack1.push(20);
    try stack1.push(100);

    stack1.show();

    print("pop1: {}\n", .{stack1.pop()});

    stack1.show();

    _ = stack1.pop();
    stack1.show();
    _ = stack1.pop();
    stack1.show();
    _ = stack1.pop();
    stack1.show();
    _ = stack1.pop();
    stack1.show();
}
