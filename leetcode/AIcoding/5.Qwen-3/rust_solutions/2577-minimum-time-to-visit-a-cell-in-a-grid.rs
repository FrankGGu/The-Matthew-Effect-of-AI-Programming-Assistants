impl Solution {

use std::collections::{BinaryHeap, HashSet};

struct Solution;

impl Solution {
    pub fn minimum_time_to_visit_cell(grid: Vec<Vec<i32>>, start_x: i32, start_y: i32, end_x: i32, end_y: i32) -> i32 {
        let (rows, cols) = (grid.len(), grid[0].len());
        let mut visited = HashSet::new();
        let mut pq = BinaryHeap::new();
        pq.push((0, start_x, start_y));
        visited.insert((start_x, start_y));

        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        while let Some((time, x, y)) = pq.pop() {
            if x == end_x && y == end_y {
                return time;
            }

            for &(dx, dy) in &directions {
                let nx = x + dx;
                let ny = y + dy;
                if nx >= 0 && ny >= 0 && nx < rows as i32 && ny < cols as i32 {
                    let next_time = time + grid[nx as usize][ny as usize];
                    if !visited.contains(&(nx, ny)) {
                        visited.insert((nx, ny));
                        pq.push((next_time, nx, ny));
                    }
                }
            }
        }

        -1
    }
}
}