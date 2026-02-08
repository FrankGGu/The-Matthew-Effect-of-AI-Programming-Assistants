impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn k_longest_subarrays(nums: Vec<i32>, k: i32) -> i32 {
        let mut result = 0;
        let n = nums.len();
        let k = k as usize;

        for i in 0..=n - k {
            let subarray = &nums[i..i + k];
            let mut unique = HashSet::new();
            let mut sum = 0;

            for &num in subarray {
                if !unique.contains(&num) {
                    unique.insert(num);
                    sum += num;
                }
            }

            result += sum;
        }

        result
    }
}
}