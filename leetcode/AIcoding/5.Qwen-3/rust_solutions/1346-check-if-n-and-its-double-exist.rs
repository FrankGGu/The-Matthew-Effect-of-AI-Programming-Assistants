impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn check_if_exist(arr: Vec<i32>) -> bool {
        let mut seen = HashSet::new();

        for &num in &arr {
            if seen.contains(&(num * 2)) || seen.contains(&(num / 2)) {
                return true;
            }
            seen.insert(num);
        }

        false
    }
}
}