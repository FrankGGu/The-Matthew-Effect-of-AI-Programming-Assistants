impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let mut set = HashSet::new();
        for &num in &nums {
            set.insert(num % 3);
        }
        if set.len() == 1 {
            return 0;
        }
        let mut count = 0;
        for &num in &nums {
            if num % 3 != 0 {
                count += 1;
            }
        }
        count
    }
}
}