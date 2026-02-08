impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_identical_pairs(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut freq = HashMap::new();

        for num in nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        for &v in freq.values() {
            if v >= 2 {
                count += v * (v - 1) / 2;
            }
        }

        count
    }
}
}