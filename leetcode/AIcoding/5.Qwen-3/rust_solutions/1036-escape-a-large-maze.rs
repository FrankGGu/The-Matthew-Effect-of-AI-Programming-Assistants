impl Solution {

use std::collections::{HashSet, VecDeque};

struct Solution;

impl Solution {
    pub fn is_escape_possible(escape_positions: Vec<Vec<i32>>, target: Vec<i32>) -> bool {
        let (rows, cols) = (2000, 2000);
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        let (tx, ty) = (target[0], target[1]);

        for pos in &escape_positions {
            let (x, y) = (pos[0], pos[1]);
            if x >= 0 && x < rows as i32 && y >= 0 && y < cols as i32 {
                queue.push_back((x, y));
                visited.insert((x, y));
            }
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        while let Some((x, y)) = queue.pop_front() {
            if x == tx && y == ty {
                return true;
            }

            for &(dx, dy) in &directions {
                let nx = x + dx;
                let ny = y + dy;
                if nx >= 0 && nx < rows as i32 && ny >= 0 && ny < cols as i32 {
                    let key = (nx, ny);
                    if !visited.contains(&key) {
                        visited.insert(key);
                        queue.push_back(key);
                    }
                }
            }
        }

        false
    }
}
}