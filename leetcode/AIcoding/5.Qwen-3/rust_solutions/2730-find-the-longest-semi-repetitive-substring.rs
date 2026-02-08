impl Solution {

use std::cmp::max;

impl Solution {
    pub fn longest_semi_repetitive_substring(s: String) -> i32 {
        let s: Vec<char> = s.chars().collect();
        let n = s.len();
        let mut max_len = 0;

        for i in 0..n {
            let mut count = 0;
            for j in i..n {
                if j > 0 && s[j] == s[j - 1] {
                    count += 1;
                }
                if count <= 1 {
                    max_len = max(max_len, j - i + 1);
                } else {
                    break;
                }
            }
        }

        max_len as i32
    }
}
}