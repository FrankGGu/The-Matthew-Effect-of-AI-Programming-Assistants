impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn take_attendance(n: i32, s: String) -> i32 {
        let mut present = HashSet::new();
        for c in s.chars() {
            if c.is_ascii_digit() {
                let num = c.to_digit(10).unwrap();
                present.insert(num);
            }
        }
        for i in 1..=n {
            if !present.contains(&i) {
                return i;
            }
        }
        n + 1
    }
}
}