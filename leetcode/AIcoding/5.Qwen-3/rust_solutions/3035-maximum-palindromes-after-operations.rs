impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_palindromes_after_operations(mut nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut odd_count = 0;
        let mut even_count = 0;

        for &count in freq.values() {
            if count % 2 == 0 {
                even_count += count / 2;
            } else {
                odd_count += 1;
                even_count += (count - 1) / 2;
            }
        }

        let mut res = 0;
        let mut pairs = 0;

        while pairs < even_count && odd_count > 0 {
            res += 2;
            pairs += 1;
            odd_count -= 1;
        }

        if odd_count > 0 {
            res += 1;
        }

        res
    }
}
}