const std = @import("std");
const print = std.debug.print;

pub fn Node(comptime T: type) type {
    return struct {
        const Self = @This();

        data: T,
        next: ?*Self = null,
        prev: ?*Self = null,

        pub fn new(data: T, next: ?*Self, prev: ?*Self) Self {
            return Self{
                .data = data,
                .next = next,
                .prev = prev,
            };
        }

        pub fn get(self: Self) T {
            return self.data;
        }
    };
}

pub fn Stack(comptime T: type) type {
    return struct {
        const Self = @This();

        head: ?*Node(T) = null,
        size: u32 = 0,

        /// # Stack init function
        /// ---------------------------------------------------
        /// Initialize the stack with the given datatype
        /// ---------------------------------------------------
        /// Return:
        /// > `Stack(T)`: Stack with the provided datatype `T`
        /// ---------------------------------------------------
        pub fn init() Self {
            return Self{};
        }

        /// # Stack push function
        /// ---------------------------------------
        /// Pushes `data` onto the stack.
        /// ---------------------------------------
        /// Arguments:
        /// > `data`: data to push to stack
        /// ---------------------------------------
        pub fn push(self: *Self, data: T) !void {
            var new_node = try std.heap.page_allocator.create(Node(T));
            new_node.data = data;
            if (self.size == 0) {
                self.head = new_node;
                self.head.?.next = null;
            } else {
                new_node.next = self.head;
                self.head = new_node;
            }
            self.size += 1;
        }

        /// # Stack pop() function
        /// ---------------------------------------
        /// Remove the first element of the stack, 
        /// free the memory and return the element
        /// ---------------------------------------
        /// Return:
        /// > `T`: value of the topmost element
        /// ---------------------------------------
        pub fn pop(self: *Self) ?T {
            if (self.size < 1) {
                return null;
            }
            var data = self.head.?.data;
            var head = self.head;
            self.head = self.head.?.next;
            self.size -= 1;
            // Free memory of the Node
            std.heap.page_allocator.destroy(head.?);
            return data;
        }

        /// # Stack show function
        /// -------------------------------------------
        /// Print the stack into the terminal
        /// "<empty>" will be printed if stack size is 0
        /// -------------------------------------------
        pub fn show(self: Self) void {
            if (self.size < 1) {
                print("<empty>\n", .{});
                return;
            }
            var node = self.head;
            print("|", .{});
            while (node != null) {
                print(" {} |", .{node.?.data});
                node = node.?.next;
            }
            print("\n", .{});
        }
    };
}
