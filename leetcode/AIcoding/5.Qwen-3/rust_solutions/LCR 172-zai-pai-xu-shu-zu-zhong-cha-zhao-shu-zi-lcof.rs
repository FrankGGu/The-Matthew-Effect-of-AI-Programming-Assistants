impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn num_pairs_divisible_by_60(mut nums: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        let mut result = 0;

        for num in nums.iter_mut() {
            let remainder = *num % 60;
            let complement = (60 - remainder) % 60;

            if let Some(&c) = count.get(&complement) {
                result += c;
            }

            *count.entry(remainder).or_insert(0) += 1;
        }

        result
    }
}
}