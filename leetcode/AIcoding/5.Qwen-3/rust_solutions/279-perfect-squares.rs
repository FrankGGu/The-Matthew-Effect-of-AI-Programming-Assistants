impl Solution {

use std::collections::VecDeque;

struct Solution {}

impl Solution {
    pub fn num_squares(mut n: i32) -> i32 {
        let mut queue = VecDeque::new();
        queue.push_back(n);
        let mut visited = vec![false; n as usize + 1];
        visited[n as usize] = true;
        let mut steps = 0;

        while !queue.is_empty() {
            let size = queue.len();
            for _ in 0..size {
                let current = queue.pop_front().unwrap();
                if current == 0 {
                    return steps;
                }
                let mut i = 1;
                while i * i <= current {
                    let next = current - i * i;
                    if !visited[next as usize] {
                        visited[next as usize] = true;
                        queue.push_back(next);
                    }
                    i += 1;
                }
            }
            steps += 1;
        }

        -1
    }
}
}