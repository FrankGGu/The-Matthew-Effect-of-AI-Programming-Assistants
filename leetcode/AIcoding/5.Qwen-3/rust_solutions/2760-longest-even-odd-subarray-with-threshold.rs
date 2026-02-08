impl Solution {

use std::cmp::max;

impl Solution {
    pub fn longest_even_odd_subarray(nums: Vec<i32>, threshold: i32) -> i32 {
        let n = nums.len();
        let mut max_len = 0;
        let mut current_len = 0;
        let mut prev_parity = -1;

        for &num in &nums {
            if num > threshold {
                current_len = 0;
                prev_parity = -1;
                continue;
            }

            let current_parity = num % 2;

            if prev_parity == -1 {
                current_len = 1;
            } else if (prev_parity + current_parity) == 1 {
                current_len += 1;
            } else {
                current_len = 1;
            }

            max_len = max(max_len, current_len);
            prev_parity = current_parity;
        }

        max_len
    }
}
}