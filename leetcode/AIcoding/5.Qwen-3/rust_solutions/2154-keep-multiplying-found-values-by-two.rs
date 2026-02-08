impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn find_final_value(mut nums: Vec<i32>, mut original: i32) -> i32 {
        let mut num_set: HashSet<i32> = nums.into_iter().collect();

        while num_set.contains(&original) {
            original *= 2;
        }

        original
    }
}
}