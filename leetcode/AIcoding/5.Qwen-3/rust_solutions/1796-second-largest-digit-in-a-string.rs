impl Solution {

use std::collections::BTreeSet;

impl Solution {
    pub fn second_max(s: String) -> i32 {
        let mut digits = BTreeSet::new();
        for c in s.chars() {
            if c.is_ascii_digit() {
                digits.insert(c.to_digit(10).unwrap());
            }
        }
        if digits.len() < 2 {
            return -1;
        }
        let mut iter = digits.iter().rev();
        iter.next();
        *iter.next().unwrap_or(&-1)
    }
}
}