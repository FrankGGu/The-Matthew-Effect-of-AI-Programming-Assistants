impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn minimum_obstacle_removal(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();
        let mut visited = vec![vec![false; cols]; rows];
        let mut queue = VecDeque::new();
        queue.push_back((0, 0, 0));
        visited[0][0] = true;

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        while let Some((r, c, cost)) = queue.pop_front() {
            if r == rows - 1 && c == cols - 1 {
                return cost;
            }
            for &(dr, dc) in &directions {
                let nr = r as i32 + dr;
                let nc = c as i32 + dc;
                if nr >= 0 && nr < rows as i32 && nc >= 0 && nc < cols as i32 && !visited[nr as usize][nc as usize] {
                    visited[nr as usize][nc as usize] = true;
                    if grid[nr as usize][nc as usize] == 0 {
                        queue.push_front((nr as usize, nc as usize, cost));
                    } else {
                        queue.push_back((nr as usize, nc as usize, cost + 1));
                    }
                }
            }
        }

        -1
    }
}
}