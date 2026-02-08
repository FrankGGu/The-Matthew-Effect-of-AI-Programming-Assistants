impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn shortest_path(grid: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        let mut queue = VecDeque::new();
        let mut visited = HashSet::new();

        queue.push_back((0, 0, k));
        visited.insert((0, 0, k));

        let mut steps = 0;

        while !queue.is_empty() {
            let size = queue.len();
            for _ in 0..size {
                let (x, y, rem) = queue.pop_front().unwrap();

                if x == m - 1 && y == n - 1 {
                    return steps;
                }

                for &(dx, dy) in &directions {
                    let nx = x as i32 + dx;
                    let ny = y as i32 + dy;

                    if nx >= 0 && ny >= 0 && nx < m as i32 && ny < n as i32 {
                        let nx = nx as usize;
                        let ny = ny as usize;
                        let new_rem = if grid[nx][ny] == 1 { rem - 1 } else { rem };

                        if new_rem >= 0 && !visited.contains(&(nx, ny, new_rem)) {
                            visited.insert((nx, ny, new_rem));
                            queue.push_back((nx, ny, new_rem));
                        }
                    }
                }
            }
            steps += 1;
        }

        -1
    }
}
}