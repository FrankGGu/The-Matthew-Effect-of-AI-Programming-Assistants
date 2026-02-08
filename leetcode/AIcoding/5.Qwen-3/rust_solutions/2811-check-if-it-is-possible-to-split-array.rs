impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn is_splitable(nums: Vec<i32>, m: i32) -> bool {
        let mut prefix_sum = 0;
        let mut seen = HashSet::new();

        for &num in &nums {
            prefix_sum += num;
            if seen.contains(&(prefix_sum - m)) {
                return true;
            }
            seen.insert(prefix_sum);
        }

        false
    }
}
}