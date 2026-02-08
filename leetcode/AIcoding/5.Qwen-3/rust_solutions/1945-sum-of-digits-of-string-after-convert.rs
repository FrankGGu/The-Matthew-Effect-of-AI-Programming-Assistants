impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn sum_digits(s: String, k: i32) -> i32 {
        let mut current = s;
        for _ in 0..k {
            let mut new_s = String::new();
            for c in current.chars() {
                let digit = (c as u8 - b'a' + 1) as i32;
                new_s.push_str(&digit.to_string());
            }
            current = new_s;
        }
        current.chars().map(|c| c.to_digit(10).unwrap() as i32).sum()
    }
}
}