impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn most_frequent_even(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        let mut max_freq = 0;
        let mut result = -1;

        for &num in &nums {
            if num % 2 == 0 {
                let count = freq.entry(num).or_insert(0);
                *count += 1;
                if *count > max_freq || (*count == max_freq && num < result) {
                    max_freq = *count;
                    result = num;
                }
            }
        }

        result
    }
}
}