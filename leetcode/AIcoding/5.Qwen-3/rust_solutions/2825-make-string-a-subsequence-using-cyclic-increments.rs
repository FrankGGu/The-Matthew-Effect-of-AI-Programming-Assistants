impl Solution {

use std::cmp::min;

impl Solution {
    pub fn is_subsequence(mut s: String, mut t: String) -> bool {
        let mut i = 0;
        let mut j = 0;
        let s_len = s.len();
        let t_len = t.len();

        while i < s_len && j < t_len {
            if s.chars().nth(i).unwrap() == t.chars().nth(j).unwrap() {
                i += 1;
            }
            j += 1;
        }

        i == s_len
    }

    pub fn can_replace(s: &str, t: &str) -> bool {
        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();
        let mut i = 0;
        let mut j = 0;
        let s_len = s_chars.len();
        let t_len = t_chars.len();

        while i < s_len && j < t_len {
            let sc = s_chars[i];
            let tc = t_chars[j];

            if sc == tc {
                i += 1;
                j += 1;
                continue;
            }

            let diff = (tc as u8 - sc as u8 + 26) % 26;
            if diff <= 1 {
                i += 1;
                j += 1;
            } else {
                return false;
            }
        }

        i == s_len
    }

    pub fn is_subsequence_after_cyclic_increments(s: String, t: String) -> bool {
        let mut t_iter = t.chars();
        for c in s.chars() {
            let mut found = false;
            while let Some(tc) = t_iter.next() {
                if tc == c {
                    found = true;
                    break;
                }
                let diff = (tc as u8 - c as u8 + 26) % 26;
                if diff <= 1 {
                    found = true;
                    break;
                }
            }
            if !found {
                return false;
            }
        }
        true
    }

    pub fn can_make_subsequence(s: String, t: String) -> bool {
        Self::is_subsequence_after_cyclic_increments(s, t)
    }
}
}