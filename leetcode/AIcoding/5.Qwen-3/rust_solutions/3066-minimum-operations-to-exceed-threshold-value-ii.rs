impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums;
        let mut operations = 0;
        let mut queue = VecDeque::new();

        for num in &nums {
            queue.push_back(*num);
        }

        while queue.len() >= 2 {
            let mut sum = 0;
            let mut count = 0;

            while queue.len() > 0 && sum < k {
                sum += queue.pop_front().unwrap();
                count += 1;
            }

            if sum < k {
                return -1;
            }

            operations += 1;

            if count > 1 {
                queue.push_back(sum);
            }
        }

        operations
    }
}
}