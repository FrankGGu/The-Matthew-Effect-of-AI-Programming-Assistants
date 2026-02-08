impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn minimum_time_to_initial_state(s: String, k: i32) -> i32 {
        let n = s.len();
        let mut q = VecDeque::new();
        q.push_back((0, 0));
        let mut visited = vec![false; n];
        visited[0] = true;

        while let Some((pos, time)) = q.pop_front() {
            if pos == n {
                return time;
            }
            if time + 1 <= k {
                if pos + 1 < n && !visited[pos + 1] {
                    visited[pos + 1] = true;
                    q.push_back((pos + 1, time + 1));
                }
            }
            if time + 1 <= k {
                let next_pos = (pos + 1) % n;
                if !visited[next_pos] {
                    visited[next_pos] = true;
                    q.push_back((next_pos, time + 1));
                }
            }
        }
        n as i32
    }
}
}