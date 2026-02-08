impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn number_of_copy_arrays(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut result = 1;
        for &count in freq.values() {
            result = (result * count) % 1_000_000_007;
        }

        result
    }
}
}