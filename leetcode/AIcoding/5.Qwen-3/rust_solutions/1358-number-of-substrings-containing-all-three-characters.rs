impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn number_of_substrings(s: String) -> i32 {
        let mut count = HashMap::new();
        let mut left = 0;
        let mut result = 0;
        let mut unique = 0;

        for right in 0..s.len() {
            let c = s.as_bytes()[right];
            *count.entry(c).or_insert(0) += 1;
            if *count.get(&c).unwrap() == 1 {
                unique += 1;
            }

            while unique == 3 {
                result += s.len() - right;
                let left_c = s.as_bytes()[left];
                *count.get_mut(&left_c).unwrap() -= 1;
                if *count.get(&left_c).unwrap() == 0 {
                    unique -= 1;
                }
                left += 1;
            }
        }

        result as i32
    }
}
}