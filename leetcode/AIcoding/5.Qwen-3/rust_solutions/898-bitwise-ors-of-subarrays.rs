impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn subarray_bitor(nums: Vec<i32>) -> i32 {
        let mut result = HashSet::new();
        let mut prev = HashSet::new();

        for num in nums {
            let mut curr = HashSet::new();
            curr.insert(num);
            for p in &prev {
                curr.insert(*p | num);
            }
            prev = curr;
            result.extend(&prev);
        }

        result.len() as i32
    }
}
}