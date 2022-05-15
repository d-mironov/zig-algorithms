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

pub fn list(comptime T: type) type {
    return struct {
        const Self = @This();

        head: ?*Node(T) = null,
        tail: ?*Node(T) = null,
        size: u32 = 0,
        /// # LinkedList init function
        /// ----------------------------------------------
        /// Initialize the `list` with the given datatype
        /// ----------------------------------------------
        /// Return:
        /// > Object of `list`
        /// ----------------------------------------------
        pub fn init() Self {
            return Self{};
        }

        /// # `list` - empty check function
        /// ----------------------------------------------
        /// Checks if the list is empty
        /// ----------------------------------------------
        /// Return:
        /// > `bool`: `true` if empty, else `false`.
        /// ----------------------------------------------
        pub fn is_empty(self: Self) bool {
            return (self.size == 0);
        }

        /// # `list` push back function
        /// ---------------------------------------------------------------
        /// Appends the given element to the end of the list
        /// ---------------------------------------------------------------
        /// Args:
        /// > `data`: Element to be appended to list
        /// Return:
        /// > `bool`: `true` if memory allocation successful, else `false`
        /// ---------------------------------------------------------------
        pub fn push_back(self: *Self, data: T) bool {
            var new_node = std.heap.page_allocator.create(Node(T)) catch return false;
            new_node.data = data;

            if (self.size == 0) {
                self.head = new_node;
                self.head.?.next = null;
                self.head.?.prev = null;
                self.tail = new_node;
                self.tail.?.next = null;
                self.tail.?.prev = null;
            } else {
                new_node.next = null;
                new_node.prev = self.tail;
                self.tail.?.next = new_node;
                self.tail = new_node;
            }
            self.size += 1;
            return true;
        }

        /// # `list` remove from back function
        /// ---------------------------------------------------------------
        /// Deletes and deallocates the value from the tail of the list 
        /// and returns the deleted value.
        /// ---------------------------------------------------------------
        /// Return:
        /// > `T`: value of last element on success, `null` else
        /// ---------------------------------------------------------------
        pub fn pop_back(self: *Self) ?T {
            if (self.size == 0) {
                return null;
            }

            var tmp = self.tail;
            var out = tmp.?.data;
            self.tail = self.tail.?.prev;
            self.tail.?.next = null;
            std.heap.page_allocator.destroy(tmp.?);
            self.size -= 1;
            return out;
        }

        /// # `list` add to front function
        /// ---------------------------------------------------------------
        /// Adds an element to the front of the `list` and shift the 
        /// remaining elements to the right.
        /// Returns `true` on success.
        /// ---------------------------------------------------------------
        /// Args:
        /// > `data`: Data to be put at the front
        /// Return:
        /// > `bool`: `true` if allocation successful, `false` else.
        /// ---------------------------------------------------------------
        pub fn push_front(self: *Self, data: T) bool {
            var new_node = std.heap.page_allocator.create(Node(T)) catch return false;
            new_node.data = data;

            if (self.size == 0) {
                self.head = new_node;
                self.head.?.next = null;
                self.head.?.prev = null;
                self.tail = new_node;
                self.tail.?.next = null;
                self.tail.?.prev = null;
            } else {
                new_node.next = self.head;
                new_node.prev = null;
                self.head.?.prev = new_node;
                self.head = new_node;
            }
            self.size += 1;
            return true;
        }

        /// # `list` remove from front function
        /// ---------------------------------------------------------------
        /// Deletes and deallocates the value from the front of the list 
        /// and returns the deleted value.
        /// ---------------------------------------------------------------
        /// Return:
        /// > `T`: value of first element on success, `null` else
        /// ---------------------------------------------------------------
        pub fn pop_front(self: *Self) ?T {
            if (self.size == 0) {
                return null;
            }
            var tmp = self.head;
            var out = self.head.?.data;
            self.head = self.head.?.next;
            self.head.?.prev = null;
            std.heap.page_allocator.destroy(tmp.?);
            self.size -= 1;
            return out;
        }

        /// # `list` - put element at the given position
        /// ---------------------------------------------------------------
        /// Puts the element at the position specified by `idx`. Shift 
        /// rest of the elements to the right.
        /// Does nothing if out of bound.
        /// ---------------------------------------------------------------
        /// Args:
        /// > `idx`: Index to put the data in
        /// > `data`: Data to insert into the list
        /// Return:
        /// > `bool`: `true` on success, `false` else.
        /// ---------------------------------------------------------------
        pub fn insert(self: *Self, idx: i32, data: T) bool {
            if (idx == 0) {
                return self.push_front(data);
            } else if (idx == self.size) {
                return self.push_back(data);
            }
            // create loop-counter
            var cnt: u32 = 0;
            var cur = self.head;
            // Iterate through list until `idx` or until EOL
            while (cnt < idx and cur != null and cnt < self.size) : (cnt += 1) {
                cur = cur.?.next;
            }
            // Return if EOL
            if (cnt >= self.size) {
                return false;
            }
            // Create new data-node
            var new_node = std.heap.page_allocator.create(Node(T)) catch return false;
            new_node.data = data;
            new_node.next = cur;
            new_node.prev = cur.?.prev;
            cur.?.prev = new_node;
            new_node.prev.?.next = new_node;
            self.size += 1;
            return true;
        }

        pub fn replace(self: *Self, idx: i32, data: T) bool {
            if (self.size == 0) {
                return false;
            }
            if (idx == 0) {
                self.head.?.data = data;
                return true;
            } else if (idx == self.size) {
                self.head.?.data = data;
            }
            // create loop-counter
            var cnt: u32 = 0;
            var cur = self.head;
            // Iterate through list until `idx` or until EOL
            while (cnt < idx and cur != null and cnt < self.size) : (cnt += 1) {
                cur = cur.?.next;
            }
            // Return if EOL
            if (cnt >= self.size) {
                return false;
            }
            cur.?.data = data;
            return true;
        }

        /// TODO: List clear with memory deallocation
        pub fn clear(self: *Self) void {
            if (self.size == 0) {
                return;
            }
        }

        /// # `list` - Get the element at the specified index
        /// ---------------------------------------------------------------
        /// Returns the value from the list specified by the index `idx`. 
        /// Returns the data if element found, `null` else.
        /// ---------------------------------------------------------------
        /// Args:
        /// > `idx`: Index to get the data from
        /// Return:
        /// > `?T`: data if found at index `idx`, else `null`.
        /// ---------------------------------------------------------------
        pub fn get(self: Self, idx: i32) ?T {
            if (self.size == 0) {
                return null;
            }

            var cnt: u32 = 0;
            var cur = self.head;
            // Iterate through list until `idx` or until EOL
            while (cnt < idx and cur != null and cnt < self.size) : (cnt += 1) {
                cur = cur.?.next;
            }
            if (cur == null or cnt >= self.size) {
                return null;
            }
            return cur.?.data;
        }

        /// # `list` - Delete the element at the specified index
        /// ----------------------------------------------------------------
        /// Deletes the value at the specified index and returns it's value.
        /// Doesn't delete anything if element is not found.
        /// Data gets deallocated on success.
        /// ----------------------------------------------------------------
        /// Args:
        /// > `idx`: Index to delete the data from
        /// Return:
        /// > `?T`: data if deleted at index `idx`, else `null`.
        /// ----------------------------------------------------------------
        pub fn del(self: *Self, idx: i32) ?T {
            if (self.size == 0 or idx > self.size - 1) {
                return null;
            }
            if (idx == 0) {
                return self.pop_front();
            } else if (idx == self.size - 1) {
                return self.pop_back();
            }

            var cnt: u32 = 0;
            var cur = self.head;
            // Iterate through list until `idx` or until EOL
            while (cnt < idx and cur != null and cnt < self.size) : (cnt += 1) {
                cur = cur.?.next;
            }
            if (cur == null or cnt >= self.size) {
                return null;
            }
            var tmp = cur;
            var out = tmp.?.data;
            cur.?.prev.?.next = cur.?.next;
            cur.?.next.?.prev = cur.?.prev;
            std.heap.page_allocator.destroy(tmp.?);
            self.size -= 1;
            return out;
        }

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
