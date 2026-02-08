impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn shortest_path_binary_matrix(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        if grid[0][0] != 0 || grid[n - 1][n - 1] != 0 {
            return -1;
        }

        let mut queue = VecDeque::new();
        queue.push_back((0, 0, 1));
        let mut visited = HashSet::new();
        visited.insert((0, 0));

        let directions = [
            (-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1),
        ];

        while let Some((r, c, dist)) = queue.pop_front() {
            if r == n - 1 && c == n - 1 {
                return dist;
            }

            for &(dr, dc) in &directions {
                let nr = r as i32 + dr;
                let nc = c as i32 + dc;
                if nr >= 0 && nr < n as i32 && nc >= 0 && nc < n as i32 {
                    let nr = nr as usize;
                    let nc = nc as usize;
                    if grid[nr][nc] == 0 && !visited.contains(&(nr, nc)) {
                        visited.insert((nr, nc));
                        queue.push_back((nr, nc, dist + 1));
                    }
                }
            }
        }

        -1
    }
}
}