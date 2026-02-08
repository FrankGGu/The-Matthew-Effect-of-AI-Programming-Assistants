impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn min_operations(robots: Vec<i32>, parts: Vec<i32>) -> i32 {
        let mut robots = robots;
        let mut parts = parts;
        robots.sort();
        parts.sort();
        let mut queue = VecDeque::new();
        for &r in &robots {
            queue.push_back(r);
        }
        let mut operations = 0;
        for &p in &parts {
            while let Some(&r) = queue.front() {
                if r <= p {
                    queue.pop_front();
                    break;
                } else {
                    let r = queue.pop_front().unwrap();
                    queue.push_back(r);
                    operations += 1;
                }
            }
        }
        operations
    }
}
}