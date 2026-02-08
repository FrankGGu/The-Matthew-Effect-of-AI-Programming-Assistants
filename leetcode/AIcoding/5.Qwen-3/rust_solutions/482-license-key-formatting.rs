impl Solution {

use std::iter;

impl Solution {
    pub fn license_key_formatting(s: String, k: i32) -> String {
        let k = k as usize;
        let s = s.chars().filter(|c| !c.is_whitespace()).rev();
        let mut result = String::new();
        let mut count = 0;

        for (i, c) in s.enumerate() {
            if count == k {
                result.push('-');
                count = 0;
            }
            result.push(c.to_ascii_uppercase());
            count += 1;
        }

        result.chars().rev().collect()
    }
}
}