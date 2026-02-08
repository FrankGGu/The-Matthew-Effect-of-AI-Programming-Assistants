impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn is_substring_present(s: String, n: i32) -> bool {
        let mut seen = HashSet::new();
        let s_bytes = s.as_bytes();
        let n = n as usize;

        for i in 0..s.len() {
            for j in i + 1..=s.len() {
                let substr = &s_bytes[i..j];
                let num = usize::from_str_radix(std::str::from_utf8(substr).unwrap(), 2).unwrap();
                if num <= n {
                    seen.insert(num);
                }
                if seen.len() == n {
                    return true;
                }
            }
        }

        false
    }
}
}