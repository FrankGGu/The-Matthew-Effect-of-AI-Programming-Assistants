impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn largest_odd_string(mut nums: Vec<i32>) -> String {
        let mut set = HashSet::new();
        for &num in &nums {
            set.insert(num);
        }
        nums.sort_by(|a, b| b.cmp(a));
        for num in &nums {
            if *num % 2 == 1 {
                return num.to_string();
            }
        }
        "-1".to_string()
    }
}
}