impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_window(s: String, t: String) -> String {
        if s.is_empty() || t.is_empty() || s.len() < t.len() {
            return String::new();
        }

        let mut need = HashMap::new();
        let mut window = HashMap::new();

        for c in t.chars() {
            *need.entry(c).or_insert(0) += 1;
        }

        let mut left = 0;
        let mut right = 0;
        let mut valid = 0;
        let mut start = 0;
        let mut length = usize::MAX;

        let s_chars: Vec<char> = s.chars().collect();

        while right < s_chars.len() {
            let c = s_chars[right];
            right += 1;

            if need.contains_key(&c) {
                *window.entry(c).or_insert(0) += 1;
                if window[&c] == need[&c] {
                    valid += 1;
                }
            }

            while valid == need.len() {
                if right - left < length {
                    start = left;
                    length = right - left;
                }

                let d = s_chars[left];
                left += 1;

                if need.contains_key(&d) {
                    if window[&d] == need[&d] {
                        valid -= 1;
                    }
                    window.entry(d).and_modify(|e| *e -= 1);
                }
            }
        }

        if length == usize::MAX {
            String::new()
        } else {
            s_chars[start..start + length].iter().collect()
        }
    }
}

struct Solution;
}