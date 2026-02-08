impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn is_possible(queries: Vec<Vec<i32>>, k: i32) -> bool {
        let mut queue = VecDeque::new();
        for q in queries {
            let (x, y) = (q[0], q[1]);
            let delta = x - y;
            if delta > 0 {
                queue.push_back(delta);
            }
        }

        let mut current = 0;
        for _ in 0..k {
            while let Some(&d) = queue.front() {
                if d <= current {
                    queue.pop_front();
                } else {
                    break;
                }
            }
            if !queue.is_empty() {
                current += 1;
            }
        }

        queue.is_empty()
    }
}
}