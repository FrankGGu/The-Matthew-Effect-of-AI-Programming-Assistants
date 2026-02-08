impl Solution {

use std::collections::{BinaryHeap, HashSet};

#[derive(Copy, Clone, PartialEq, Eq, Hash)]
struct State {
    row: usize,
    col: usize,
    effort: i32,
}

impl Solution {
    pub fn find_min_effort(rooms: Vec<Vec<i32>>) -> i32 {
        let rows = rooms.len();
        let cols = rooms[0].len();
        let mut visited = HashSet::new();
        let mut heap = BinaryHeap::new();
        heap.push(State { row: 0, col: 0, effort: 0 });

        while let Some(State { row, col, effort }) = heap.pop() {
            if row == rows - 1 && col == cols - 1 {
                return effort;
            }
            if visited.contains(&State { row, col, effort }) {
                continue;
            }
            visited.insert(State { row, col, effort });

            for (dr, dc) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
                let r = row as i32 + dr;
                let c = col as i32 + dc;
                if r >= 0 && r < rows as i32 && c >= 0 && c < cols as i32 {
                    let new_row = r as usize;
                    let new_col = c as usize;
                    let new_effort = effort.max((rooms[row][col] - rooms[new_row][new_col]).abs());
                    heap.push(State { row: new_row, col: new_col, effort: new_effort });
                }
            }
        }

        -1
    }
}
}