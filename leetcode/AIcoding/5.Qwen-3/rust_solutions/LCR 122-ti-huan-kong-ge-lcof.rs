impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn path_encryption(s: String, k: i32) -> String {
        let mut result = String::new();
        let mut visited = HashSet::new();
        let mut current = 0;
        let k = k as usize;

        while current < s.len() && !visited.contains(&current) {
            visited.insert(current);
            result.push(s.chars().nth(current).unwrap());
            current = (current + k) % s.len();
        }

        result
    }
}
}