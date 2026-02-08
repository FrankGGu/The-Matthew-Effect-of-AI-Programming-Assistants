impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let mut queue = VecDeque::new();
        for &num in &nums {
            if num != 0 {
                queue.push_back(num);
            }
        }

        let mut operations = 0;
        while !queue.is_empty() {
            let mut min = *queue.front().unwrap();
            for &num in &queue {
                min = std::cmp::min(min, num);
            }

            for i in 0..queue.len() {
                let val = queue[i];
                queue[i] = val - min;
                if queue[i] == 0 {
                    queue.remove(i);
                    break;
                }
            }

            operations += 1;
        }

        operations
    }
}
}