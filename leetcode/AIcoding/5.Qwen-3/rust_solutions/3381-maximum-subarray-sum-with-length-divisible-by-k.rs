impl Solution {

use std::cmp;

impl Solution {
    pub fn max_subarray_sum(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = nums.len();
        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i];
        }

        let mut max_sum = i32::MIN;
        let mut map = std::collections::HashMap::new();
        map.insert(0, 0);

        for i in 1..=n {
            let remainder = (prefix_sum[i] % k as i32 + k as i32) % k as i32;
            if let Some(&prev_index) = map.get(&remainder) {
                let current_sum = prefix_sum[i] - prefix_sum[prev_index];
                max_sum = cmp::max(max_sum, current_sum);
            } else {
                map.insert(remainder, i);
            }
        }

        max_sum
    }
}
}