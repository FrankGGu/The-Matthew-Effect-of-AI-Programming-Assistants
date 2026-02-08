impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn minimum_moves(bridge: Vec<i32>, jump: i32, back: i32) -> i32 {
        let n = bridge.len();
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();

        queue.push_back((0, 0));
        visited.insert(0);

        while let Some((pos, steps)) = queue.pop_front() {
            if pos == n as i32 - 1 {
                return steps;
            }

            let next_pos = pos + jump;
            if next_pos < n as i32 && bridge[next_pos as usize] == 1 && !visited.contains(&next_pos) {
                visited.insert(next_pos);
                queue.push_back((next_pos, steps + 1));
            }

            let prev_pos = pos - back;
            if prev_pos >= 0 && bridge[prev_pos as usize] == 1 && !visited.contains(&prev_pos) {
                visited.insert(prev_pos);
                queue.push_back((prev_pos, steps + 1));
            }
        }

        -1
    }
}
}