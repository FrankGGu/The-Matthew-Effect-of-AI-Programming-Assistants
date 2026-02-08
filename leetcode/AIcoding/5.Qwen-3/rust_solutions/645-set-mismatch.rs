impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn find_error_nums(nums: Vec<i32>) -> Vec<i32> {
        let mut seen = HashSet::new();
        let mut duplicate = -1;
        let mut missing = -1;

        for &num in &nums {
            if seen.contains(&num) {
                duplicate = num;
            } else {
                seen.insert(num);
            }
        }

        for i in 1..=nums.len() as i32 {
            if !seen.contains(&i) {
                missing = i;
                break;
            }
        }

        vec![duplicate, missing]
    }
}
}