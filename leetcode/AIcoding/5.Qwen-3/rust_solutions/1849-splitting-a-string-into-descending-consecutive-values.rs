impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn split_string(s: String) -> bool {
        let n = s.len();
        for i in 1..n {
            let mut prev = s[..i].parse::<i64>().unwrap();
            let mut current = i;
            let mut valid = true;
            while current < n {
                let mut next = String::new();
                while current < n && next.len() < 18 {
                    next.push(s.chars().nth(current).unwrap());
                    current += 1;
                }
                if next.is_empty() {
                    valid = false;
                    break;
                }
                let curr = next.parse::<i64>().unwrap();
                if curr != prev - 1 {
                    valid = false;
                    break;
                }
                prev = curr;
            }
            if valid {
                return true;
            }
        }
        false
    }
}
}