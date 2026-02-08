impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn di_string_match(s: String) -> Vec<i32> {
        let mut result = Vec::new();
        let mut low = 0;
        let mut high = s.len() as i32;

        for c in s.chars() {
            match c {
                'I' => {
                    result.push(low);
                    low += 1;
                },
                'D' => {
                    result.push(high);
                    high -= 1;
                },
                _ => {}
            }
        }

        result.push(low);
        result
    }
}
}