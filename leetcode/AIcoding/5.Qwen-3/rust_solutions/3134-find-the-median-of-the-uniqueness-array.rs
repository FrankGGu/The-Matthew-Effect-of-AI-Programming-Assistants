impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn median_uniqueness_array(nums: Vec<i32>) -> i32 {
        let mut unique = HashSet::new();
        for &num in &nums {
            unique.insert(num);
        }
        let mut unique_vec: Vec<i32> = unique.into_iter().collect();
        unique_vec.sort();
        unique_vec[unique_vec.len() / 2]
    }
}
}