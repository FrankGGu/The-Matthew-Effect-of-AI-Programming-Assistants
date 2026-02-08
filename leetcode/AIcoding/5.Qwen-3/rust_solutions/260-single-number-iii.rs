impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn single_number(nums: Vec<i32>) -> Vec<i32> {
        let mut seen = HashSet::new();
        let mut result = Vec::new();

        for num in nums {
            if seen.contains(&num) {
                seen.remove(&num);
            } else {
                seen.insert(num);
            }
        }

        for num in seen {
            result.push(num);
        }

        result
    }
}
}