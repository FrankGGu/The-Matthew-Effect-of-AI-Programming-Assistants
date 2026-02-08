impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn are_digits_equal(s: String) -> bool {
        let mut count = HashMap::new();
        for c in s.chars() {
            let digit = c.to_digit(10).unwrap();
            *count.entry(digit).or_insert(0) += 1;
        }
        let first = count.values().next().copied().unwrap();
        count.values().all(|&v| v == first)
    }
}
}