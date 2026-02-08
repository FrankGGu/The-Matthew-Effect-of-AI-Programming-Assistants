impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn final_array_state(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let mut dq = VecDeque::new();
        for num in nums {
            dq.push_back(num);
        }

        for _ in 0..k {
            if dq.is_empty() {
                break;
            }
            let val = dq.pop_front().unwrap();
            dq.push_back(val * 2);
        }

        dq.into_iter().collect()
    }
}
}