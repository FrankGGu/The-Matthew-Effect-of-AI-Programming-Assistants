impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn is_reachable(width: i32, height: i32, tree: Vec<Vec<i32>>) -> bool {
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((0, 0));
        visited.insert((0, 0));

        let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)];

        while let Some((x, y)) = queue.pop_front() {
            if x == width || y == height {
                return true;
            }

            for &(dx, dy) in &directions {
                let nx = x + dx;
                let ny = y + dy;

                if nx >= 0 && ny >= 0 && nx <= width && ny <= height {
                    let is_tree = tree.iter().any(|t| t[0] == nx && t[1] == ny);
                    if !is_tree && !visited.contains(&(nx, ny)) {
                        visited.insert((nx, ny));
                        queue.push_back((nx, ny));
                    }
                }
            }
        }

        false
    }
}
}