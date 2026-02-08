impl Solution {

use std::cmp;

impl Solution {
    pub fn minimize_string_value(s: String) -> String {
        let mut s: Vec<char> = s.chars().collect();
        let n = s.len();

        for i in 0..n {
            if s[i] == '?' {
                let left = if i > 0 { s[i - 1] } else { 'a' };
                let right = if i < n - 1 { s[i + 1] } else { 'z' };

                let mut c = 'a';
                let mut min_diff = cmp::max(left as u8, right as u8) - cmp::min(left as u8, right as u8);

                for ch in 'a'..='z' {
                    let diff = cmp::max(ch as u8, left as u8) - cmp::min(ch as u8, left as u8)
                        + cmp::max(ch as u8, right as u8) - cmp::min(ch as u8, right as u8);
                    if diff < min_diff {
                        min_diff = diff;
                        c = ch;
                    }
                }

                s[i] = c;
            }
        }

        s.into_iter().collect()
    }
}
}