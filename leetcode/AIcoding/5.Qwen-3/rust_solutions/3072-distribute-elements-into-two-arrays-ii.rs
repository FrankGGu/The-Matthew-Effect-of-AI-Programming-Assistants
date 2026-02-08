impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn distribute_elements_to_two_arrays(nums: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut result = 0;
        for (_, &freq) in &count {
            result += freq / 2;
        }

        result
    }
}
}