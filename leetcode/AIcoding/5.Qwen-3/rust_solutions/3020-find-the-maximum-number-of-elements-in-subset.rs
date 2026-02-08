impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn maximum_substring_size(s: String) -> i32 {
        let mut count = HashMap::new();
        let mut max_len = 0;
        let mut left = 0;

        for (right, c) in s.chars().enumerate() {
            *count.entry(c).or_insert(0) += 1;

            while count[&c] > 1 {
                let left_char = s.chars().nth(left).unwrap();
                *count.get_mut(&left_char).unwrap() -= 1;
                if count[&left_char] == 0 {
                    count.remove(&left_char);
                }
                left += 1;
            }

            max_len = max_len.max(right - left + 1);
        }

        max_len as i32
    }
}
}