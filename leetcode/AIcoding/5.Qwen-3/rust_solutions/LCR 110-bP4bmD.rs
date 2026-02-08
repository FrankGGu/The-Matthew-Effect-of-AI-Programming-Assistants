impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn all_paths_sources_target(grid: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let n = grid.len();
        let m = grid[0].len();

        let mut queue = VecDeque::new();
        queue.push_back((0, vec![0]));

        while let Some((current, path)) = queue.pop_front() {
            if current == n - 1 {
                result.push(path);
                continue;
            }

            for neighbor in 0..m {
                if grid[current][neighbor] == 1 {
                    let mut new_path = path.clone();
                    new_path.push(neighbor as i32);
                    queue.push_back((neighbor, new_path));
                }
            }
        }

        result
    }
}
}