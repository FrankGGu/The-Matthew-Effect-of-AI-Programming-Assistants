impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn lex_smallest_string(s: String) -> String {
        let mut s: Vec<char> = s.chars().collect();
        let n = s.len();

        for i in 0..n {
            if s[i] != '0' {
                break;
            }
        }

        for i in 1..n {
            if s[i] == '0' {
                continue;
            }

            for j in (0..i).rev() {
                if s[j] > s[i] {
                    s.swap(j, i);
                    return s.into_iter().collect();
                }
            }
        }

        s.into_iter().collect()
    }
}

pub struct Solution;
}