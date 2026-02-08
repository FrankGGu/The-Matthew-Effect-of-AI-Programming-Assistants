impl Solution {

use std::cmp;

impl Solution {
    pub fn is_prefix_string(nums: Vec<String>, s: String) -> bool {
        let mut current = String::new();
        for num in nums {
            current.push_str(&num);
            if current == s {
                return true;
            }
            if current.len() > s.len() {
                return false;
            }
        }
        false
    }
}
}