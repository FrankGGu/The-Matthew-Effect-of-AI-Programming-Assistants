impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn orderly_queue(s: String, k: i32) -> String {
        if k == 0 {
            return s;
        }
        if k == 1 {
            let mut min_s = s.clone();
            let s_chars: Vec<char> = s.chars().collect();
            for i in 0..s.len() {
                let rotated: String = s_chars[i..].iter().chain(s_chars[..i].iter()).collect();
                if rotated < min_s {
                    min_s = rotated;
                }
            }
            return min_s;
        }
        let mut chars: Vec<char> = s.chars().collect();
        chars.sort_unstable();
        chars.into_iter().collect()
    }
}
}