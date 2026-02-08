impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn character_replacement(s: String, k: i32) -> i32 {
        let mut max_count = 0;
        let mut max_length = 0;
        let mut char_count = HashMap::new();
        let s_bytes = s.as_bytes();
        let mut left = 0;

        for right in 0..s.len() {
            let current_char = s_bytes[right];
            *char_count.entry(current_char).or_insert(0) += 1;
            max_count = std::cmp::max(max_count, *char_count.get(&current_char).unwrap());

            while (right - left + 1) as i32 - max_count > k {
                let left_char = s_bytes[left];
                *char_count.get_mut(&left_char).unwrap() -= 1;
                left += 1;
            }

            max_length = std::cmp::max(max_length, (right - left + 1) as i32);
        }

        max_length
    }
}
}