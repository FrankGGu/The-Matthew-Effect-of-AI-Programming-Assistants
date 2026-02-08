impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn get_sneaky_numbers(nums: Vec<i32>) -> Vec<i32> {
        let mut seen = HashSet::new();
        let mut result = Vec::new();

        for &num in &nums {
            if seen.contains(&num) {
                result.push(num);
            } else {
                seen.insert(num);
            }
        }

        result
    }
}
}