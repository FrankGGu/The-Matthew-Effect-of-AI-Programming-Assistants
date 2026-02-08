impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn shortest_subarray(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        let mut dq = VecDeque::new();
        let mut result = std::i32::MAX;

        for i in 0..=n {
            while !dq.is_empty() && prefix[i] - prefix[dq.front().unwrap()] >= k {
                result = std::cmp::min(result, (i - dq.front().unwrap()) as i32);
                dq.pop_front();
            }

            while !dq.is_empty() && prefix[i] <= prefix[dq.back().unwrap()] {
                dq.pop_back();
            }

            dq.push_back(i);
        }

        if result == std::i32::MAX {
            -1
        } else {
            result
        }
    }
}
}