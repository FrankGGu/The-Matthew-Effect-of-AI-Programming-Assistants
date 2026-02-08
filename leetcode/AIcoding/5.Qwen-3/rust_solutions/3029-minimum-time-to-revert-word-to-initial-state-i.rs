impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn minimum_time_to_initial_state(word: String, speed: i32) -> i32 {
        let n = word.len();
        let mut q = VecDeque::new();
        q.push_back((0, 0));
        let mut visited = vec![false; n + 1];
        visited[0] = true;

        while let Some((pos, time)) = q.pop_front() {
            if pos == n {
                return time;
            }

            let next_pos = pos + speed as usize;
            if next_pos <= n && !visited[next_pos] {
                visited[next_pos] = true;
                q.push_back((next_pos, time + 1));
            }

            if pos < n && !visited[pos + 1] {
                visited[pos + 1] = true;
                q.push_back((pos + 1, time + 1));
            }
        }

        -1
    }
}
}