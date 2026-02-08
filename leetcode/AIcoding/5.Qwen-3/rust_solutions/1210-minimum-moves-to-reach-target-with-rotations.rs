impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn minimum_moves(grid: Vec<Vec<i32>>, target: Vec<i32>) -> i32 {
        let n = grid.len();
        let m = grid[0].len();
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((0, 0, 0, 0));
        visited.insert((0, 0, 0, 0));

        while let Some((x1, y1, x2, y2)) = queue.pop_front() {
            if (x1 == target[0] && y1 == target[1]) || (x2 == target[0] && y2 == target[1]) {
                return 0;
            }

            let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];
            for &(dx, dy) in &directions {
                let nx1 = x1 + dx;
                let ny1 = y1 + dy;
                let nx2 = x2 + dx;
                let ny2 = y2 + dy;
                if nx1 >= 0 && ny1 >= 0 && nx1 < n && ny1 < m && nx2 >= 0 && ny2 >= 0 && nx2 < n && ny2 < m && grid[nx1][ny1] == 0 && grid[nx2][ny2] == 0 {
                    if !visited.contains(&(nx1, ny1, nx2, ny2)) {
                        visited.insert((nx1, ny1, nx2, ny2));
                        queue.push_back((nx1, ny1, nx2, ny2));
                    }
                }
            }

            if x1 == x2 {
                let dir = if y1 < y2 { 1 } else { -1 };
                let new_y1 = y1 + dir;
                let new_y2 = y2 + dir;
                if new_y1 >= 0 && new_y1 < m && new_y2 >= 0 && new_y2 < m && grid[x1][new_y1] == 0 && grid[x2][new_y2] == 0 {
                    if !visited.contains(&(x1, new_y1, x2, new_y2)) {
                        visited.insert((x1, new_y1, x2, new_y2));
                        queue.push_back((x1, new_y1, x2, new_y2));
                    }
                }
            } else {
                let dir = if x1 < x2 { 1 } else { -1 };
                let new_x1 = x1 + dir;
                let new_x2 = x2 + dir;
                if new_x1 >= 0 && new_x1 < n && new_x2 >= 0 && new_x2 < n && grid[new_x1][y1] == 0 && grid[new_x2][y2] == 0 {
                    if !visited.contains(&(new_x1, y1, new_x2, y2)) {
                        visited.insert((new_x1, y1, new_x2, y2));
                        queue.push_back((new_x1, y1, new_x2, y2));
                    }
                }
            }
        }

        -1
    }
}
}