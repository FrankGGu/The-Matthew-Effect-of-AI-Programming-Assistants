impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn most_frequent(nums: Vec<i32>, key: i32) -> i32 {
        let mut freq = HashMap::new();
        let mut max_count = 0;
        let mut result = 0;

        for i in 0..nums.len() - 1 {
            if nums[i] == key {
                let next_num = nums[i + 1];
                *freq.entry(next_num).or_insert(0) += 1;
                if freq[&next_num] > max_count {
                    max_count = freq[&next_num];
                    result = next_num;
                }
            }
        }

        result
    }
}
}