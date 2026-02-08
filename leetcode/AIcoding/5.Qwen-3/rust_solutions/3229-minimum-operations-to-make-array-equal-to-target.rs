impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn min_operations_to_equal_target(target: Vec<i32>) -> i32 {
        let mut operations = 0;
        let mut queue = VecDeque::new();
        for &t in &target {
            queue.push_back(t);
        }

        while !queue.is_empty() {
            let mut new_queue = VecDeque::new();
            let mut has_non_zero = false;

            while let Some(val) = queue.pop_front() {
                if val > 0 {
                    has_non_zero = true;
                    new_queue.push_back(val - 1);
                }
            }

            if has_non_zero {
                operations += 1;
            }

            queue = new_queue;
        }

        operations
    }
}
}