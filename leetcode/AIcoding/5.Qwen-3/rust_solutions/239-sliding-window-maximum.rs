impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn max_sliding_window(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let k = k as usize;
        let n = nums.len();
        if n == 0 || k == 0 {
            return vec![];
        }

        let mut result = Vec::new();
        let mut dq = VecDeque::new();

        for i in 0..n {
            while let Some(&last) = dq.back() {
                if nums[i] >= nums[last] {
                    dq.pop_back();
                } else {
                    break;
                }
            }
            dq.push_back(i);

            if i >= k - 1 {
                while let Some(&front) = dq.front() {
                    if front <= i - k {
                        dq.pop_front();
                    } else {
                        break;
                    }
                }
                result.push(nums[dq.front().unwrap()]);
            }
        }

        result
    }
}
}