impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn time_needed_to_buy(tickets: Vec<i32>, k: i32) -> i32 {
        let mut queue = VecDeque::new();
        for (i, &t) in tickets.iter().enumerate() {
            queue.push_back((i as i32, t));
        }

        let mut time = 0;
        while let Some((i, t)) = queue.pop_front() {
            if i == k && t == 1 {
                return time + 1;
            }
            if t > 1 {
                queue.push_back((i, t - 1));
            }
            time += 1;
        }

        time
    }
}
}