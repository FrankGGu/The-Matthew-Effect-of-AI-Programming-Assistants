impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn find_unique_binary_string(nums: Vec<String>) -> String {
        let mut seen = HashSet::new();
        for num in &nums {
            seen.insert(num);
        }

        let n = nums.len();
        for i in 0..(1 << n) {
            let s = format!("{:0width$b}", i, width = n);
            if !seen.contains(&s) {
                return s;
            }
        }

        unreachable!()
    }
}
}