impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn number_of_substrings(s: String) -> i32 {
        let mut count = HashMap::new();
        let mut result = 0;
        let mut ones = 0;

        for c in s.chars() {
            if c == '1' {
                ones += 1;
            }
            *count.entry(ones).or_insert(0) += 1;
        }

        for (&k, &v) in count.iter() {
            if k > 0 {
                result += v * (v - 1) / 2;
            }
        }

        result as i32
    }
}
}