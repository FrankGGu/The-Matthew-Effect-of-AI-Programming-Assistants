impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn maximum_length(s: String) -> i32 {
        let mut max_len = 0;
        let mut seen = HashSet::new();
        let mut left = 0;
        let mut count = std::collections::HashMap::new();

        for (right, c) in s.chars().enumerate() {
            *count.entry(c).or_insert(0) += 1;

            while count[&c] > 2 {
                let left_char = s.chars().nth(left).unwrap();
                *count.get_mut(&left_char).unwrap() -= 1;
                if count[&left_char] == 0 {
                    count.remove(&left_char);
                }
                left += 1;
            }

            if count.len() <= 2 {
                max_len = std::cmp::max(max_len, right - left + 1);
            }
        }

        max_len as i32
    }
}
}