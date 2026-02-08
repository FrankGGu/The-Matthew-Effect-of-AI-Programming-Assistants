impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn min_possible_sequence(nums: Vec<i32>) -> i32 {
        let mut nums_set = HashSet::new();
        for num in &nums {
            nums_set.insert(*num);
        }

        let mut count = 1;
        let mut current = 1;

        while current <= nums.len() as i32 {
            if nums_set.contains(&current) {
                count += 1;
                current += 1;
            } else {
                return count;
            }
        }

        count
    }
}
}