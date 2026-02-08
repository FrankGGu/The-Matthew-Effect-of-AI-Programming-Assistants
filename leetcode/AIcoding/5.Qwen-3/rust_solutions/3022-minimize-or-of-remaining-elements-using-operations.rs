impl Solution {

use std::cmp::min;

impl Solution {
    pub fn min_or_after_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut result = 0;
        let mut mask = 0;

        for i in 0..30 {
            let bit = 1 << i;
            let mut count = 0;
            let mut current_mask = mask | bit;

            for &num in &nums {
                if (num & current_mask) == 0 {
                    count += 1;
                }
            }

            if count >= k {
                mask = current_mask;
                result |= bit;
            }
        }

        result
    }
}
}