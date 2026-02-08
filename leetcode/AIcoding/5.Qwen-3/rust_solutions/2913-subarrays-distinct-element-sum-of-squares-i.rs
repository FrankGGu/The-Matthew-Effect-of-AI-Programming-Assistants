impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn sum_after_operations(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut result = 0;
        for i in 0..n {
            let mut count = HashMap::new();
            for j in i..n {
                *count.entry(nums[j]).or_insert(0) += 1;
                let unique_count = count.values().filter(|&&v| v == 1).count();
                result += (unique_count as i32).pow(2);
            }
        }
        result
    }
}
}