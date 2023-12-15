const std = @import("std");
const data = @embedFile("input.txt");

pub fn main() !void {
    var lines = std.mem.tokenize(
        u8,
        data,
        "\n",
    );
    var sum: i64 = 0;
    var sum2: i64 = 0;
    while (lines.next()) |line| {
        // split line into i32 array
        var numberStrings = std.mem.tokenize(
            u8,
            line,
            " ",
        );
        var numbers = std.ArrayList(i32).init(std.heap.page_allocator);
        while (numberStrings.next()) |numberString| {
            var num: i32 = 0;
            num = try std.fmt.parseInt(i32, numberString, 10);

            try numbers.append(num);
        }

        const part1Sol = try part1(numbers);
        sum += part1Sol.items[part1Sol.items.len - 1];

        const part2Sol = try part2(numbers);
        sum2 += part2Sol.items[0];
    }
    std.debug.print("Part 1 sum: {d}\n", .{sum});
    std.debug.print("Part 2 sum: {d}\n", .{sum2});
}

fn part1(numbers: std.ArrayList(i32)) !std.ArrayList(i32) {
    var diffs = std.ArrayList(i32).init(std.heap.page_allocator);

    var same = true;
    for (numbers.items, 0..) |number, i| {
        if (i == 0) {
            continue;
        }

        try diffs.append(number - numbers.items[i - 1]);
        if (i != 1 and diffs.items[i - 1] != diffs.items[i - 2]) {
            same = false;
        }
    }
    var ans = diffs;
    if (!same) {
        ans = try part1(diffs);
    }

    // now we have the correct diff to predict the next number
    var last = numbers.items[numbers.items.len - 1];
    var diff = ans.items[ans.items.len - 1];
    var next = last + diff;

    var ans2 = std.ArrayList(i32).init(std.heap.page_allocator);
    for (numbers.items) |number| {
        try ans2.append(number);
    }
    try ans2.append(next);

    return ans2;
}

fn part2(numbers: std.ArrayList(i32)) !std.ArrayList(i32) {
    var diffs = std.ArrayList(i32).init(std.heap.page_allocator);
    for (numbers.items, 0..) |number, i| {
        if (i == 0) {
            continue;
        }

        try diffs.append(number - numbers.items[i - 1]);
    }

    var zeros = true;
    for (diffs.items) |diff| {
        if (diff != 0) {
            zeros = false;
        }
    }
    var ans = diffs;
    if (!zeros) {
        ans = try part2(diffs);
    }

    // now we have the correct diff to predict the prev number
    var first = numbers.items[0];
    var diff = ans.items[0];
    var prev = first - diff;

    var ans2 = std.ArrayList(i32).init(std.heap.page_allocator);
    try ans2.append(prev);
    for (numbers.items) |number| {
        try ans2.append(number);
    }

    return ans2;
}
