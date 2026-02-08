impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn reduction_operations(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut sorted_unique: Vec<i32> = freq.keys().cloned().collect();
        sorted_unique.sort();

        let mut operations = 0;
        let mut count = 0;

        for i in (0..sorted_unique.len() - 1).rev() {
            count += freq[&sorted_unique[i]];
            operations += count;
        }

        operations
    }
}
}