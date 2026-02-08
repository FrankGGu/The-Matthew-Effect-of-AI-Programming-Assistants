impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn minimize_concatenated_length(mut nums: Vec<i32>) -> i32 {
        let mut set = HashSet::new();
        for num in &nums {
            set.insert(*num);
        }
        let mut result = 0;
        for num in set {
            result += 1;
        }
        result
    }
}
}