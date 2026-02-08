impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn k_sum(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = nums.len();
        let mut subarrays = vec![];

        for i in 0..n - k + 1 {
            let subarray = &nums[i..i + k];
            subarrays.push(subarray.to_vec());
        }

        let mut sum_set = HashSet::new();
        for sub in &subarrays {
            let sum: i32 = sub.iter().sum();
            sum_set.insert(sum);
        }

        let mut sums: Vec<i32> = sum_set.into_iter().collect();
        sums.sort_by(|a, b| b.cmp(a));
        sums[k - 1]
    }
}
}