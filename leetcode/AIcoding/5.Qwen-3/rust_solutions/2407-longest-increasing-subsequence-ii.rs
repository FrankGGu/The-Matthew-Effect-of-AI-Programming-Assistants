impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn length_of_lis(mut nums: Vec<i32>, k: i32) -> i32 {
        let mut dp = vec![0; nums.len()];
        let mut max_len = 0;

        for i in 0..nums.len() {
            let mut left = 0;
            let mut right = max_len;

            while left < right {
                let mid = (left + right) / 2;
                if dp[mid] < nums[i] {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }

            if left == max_len {
                dp[max_len] = nums[i];
                max_len += 1;
            } else {
                dp[left] = nums[i];
            }
        }

        max_len as i32
    }
}
}