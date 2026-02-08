impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_array_length(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut pairs = 0;
        for &count in freq.values() {
            pairs += count / 2;
        }

        let total_pairs = pairs;
        let mut res = nums.len() as i32;

        for &count in freq.values() {
            let mut cnt = count;
            while cnt >= 2 && total_pairs > 0 {
                res -= 2;
                total_pairs -= 1;
                cnt -= 2;
            }
        }

        res
    }
}
}