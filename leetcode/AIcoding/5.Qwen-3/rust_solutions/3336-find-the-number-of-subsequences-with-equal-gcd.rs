impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn number_of_subsequences(gcd: i32, nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for num in &nums {
            *freq.entry(*num).or_insert(0) += 1;
        }

        let mut result = 0;
        let mut seen = HashMap::new();

        for num in &nums {
            let mut current = *num;
            let mut count = 1;
            while current > 0 {
                if let Some(&c) = seen.get(&current) {
                    count = (count + c) % 1_000_000_007;
                }
                current /= 2;
            }
            result = (result + count) % 1_000_000_007;
            *seen.entry(*num).or_insert(0) += 1;
        }

        result
    }
}
}