impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn all_k_one(mut nums: Vec<i32>, k: i32) -> i32 {
        let mut count = HashMap::new();
        let mut left = 0;
        let mut max_len = 0;

        for right in 0..nums.len() {
            *count.entry(nums[right]).or_insert(0) += 1;

            while *count.get(&nums[right]).unwrap() > k {
                *count.entry(nums[left]).or_insert(0) -= 1;
                if *count.get(&nums[left]).unwrap() == 0 {
                    count.remove(&nums[left]);
                }
                left += 1;
            }

            max_len = max_len.max((right - left + 1) as i32);
        }

        max_len
    }
}
}