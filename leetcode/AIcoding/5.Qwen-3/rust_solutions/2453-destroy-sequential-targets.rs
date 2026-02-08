impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn find_best_target(nums: Vec<i32>, space: i32) -> i32 {
        let mut queue = VecDeque::new();
        let mut max_count = 0;
        let mut result = 0;

        for (i, &num) in nums.iter().enumerate() {
            while let Some(&front) = queue.front() {
                if num - front > space {
                    queue.pop_front();
                } else {
                    break;
                }
            }

            if queue.is_empty() {
                queue.push_back(i as i32);
                max_count = 1;
                result = i as i32;
            } else {
                let count = queue.len() as i32 + 1;
                if count > max_count {
                    max_count = count;
                    result = i as i32;
                }
                queue.push_back(i as i32);
            }
        }

        result
    }
}
}