impl Solution {

use std::char;

struct Solution;

impl Solution {
    pub fn find_latest_time(s: String) -> String {
        let mut chars: Vec<char> = s.chars().collect();

        if chars[0] == '?' {
            chars[0] = '2';
        }

        if chars[1] == '?' {
            if chars[0] == '2' {
                chars[1] = '3';
            } else {
                chars[1] = '9';
            }
        }

        if chars[3] == '?' {
            chars[3] = '5';
        }

        if chars[4] == '?' {
            chars[4] = '9';
        }

        chars.iter().collect()
    }
}
}