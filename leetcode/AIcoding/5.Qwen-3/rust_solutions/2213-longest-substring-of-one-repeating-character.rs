impl Solution {

use std::cmp::max;

struct Solution;

impl Solution {
    pub fn longest_repeating_substring(s: String) -> i32 {
        let n = s.len();
        let mut max_len = 0;
        let mut left = 0;
        let mut right = 0;
        let mut count = std::collections::HashMap::new();
        let s_bytes = s.as_bytes();

        while right < n {
            let c = s_bytes[right];
            count.entry(c).and_modify(|e| *e += 1).or_insert(1);

            while *count.get(&c).unwrap() > 1 {
                let left_c = s_bytes[left];
                *count.get_mut(&left_c).unwrap() -= 1;
                if *count.get(&left_c).unwrap() == 0 {
                    count.remove(&left_c);
                }
                left += 1;
            }

            max_len = max(max_len, right - left + 1);
            right += 1;
        }

        max_len as i32
    }
}
}