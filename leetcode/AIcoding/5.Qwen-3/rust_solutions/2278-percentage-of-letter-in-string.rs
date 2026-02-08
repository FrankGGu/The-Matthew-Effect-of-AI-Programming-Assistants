impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn percentage_letter(s: String, letter: char) -> i32 {
        let mut count = 0;
        for c in s.chars() {
            if c == letter {
                count += 1;
            }
        }
        ((count as f64 / s.len() as f64) * 100.0).floor() as i32
    }
}
}