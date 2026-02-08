impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn find_smallest_missing(nums: Vec<i32>) -> i32 {
        let mut set = HashSet::new();
        for &num in &nums {
            set.insert(num);
        }
        let mut i = 0;
        while set.contains(&i) {
            i += 1;
        }
        i
    }
}
}