impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_consecutive(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = HashMap::new();
        let mut left = 0;
        let mut max_len = 0;

        for right in 0..nums.len() {
            *count.entry(nums[right]).or_insert(0) += 1;

            while *count.values().max().unwrap() > k {
                *count.entry(nums[left]).or_insert(0) -= 1;
                if *count.get(&nums[left]).unwrap() == 0 {
                    count.remove(&nums[left]);
                }
                left += 1;
            }

            max_len = std::cmp::max(max_len, (right - left + 1) as i32);
        }

        max_len
    }
}
}