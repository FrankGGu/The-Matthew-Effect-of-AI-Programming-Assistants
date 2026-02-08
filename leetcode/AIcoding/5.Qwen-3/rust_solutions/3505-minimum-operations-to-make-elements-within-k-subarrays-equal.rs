impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_operations_k_subarrays(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = nums.len();
        let mut freq = HashMap::new();
        let mut max_freq = 0;

        for i in 0..k {
            let mut count = HashMap::new();
            let mut current = nums[i];
            let mut max_count = 0;

            for j in (i..n).step_by(k) {
                *count.entry(nums[j]).or_insert(0) += 1;
                max_count = max_count.max(*count.get(&nums[j]).unwrap());
            }

            max_freq = max_freq.max(max_count);
        }

        let total = n / k;
        (total * k - max_freq) as i32
    }
}
}