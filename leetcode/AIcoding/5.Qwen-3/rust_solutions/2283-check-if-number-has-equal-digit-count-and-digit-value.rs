impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn digit_count(num: i32) -> bool {
        let mut count = HashMap::new();
        let num_str = num.to_string();

        for c in num_str.chars() {
            let digit = c as u8 - b'0';
            *count.entry(digit).or_insert(0) += 1;
        }

        for (digit, &freq) in &count {
            if freq != *count.get(&digit).unwrap() {
                return false;
            }
        }

        true
    }
}
}