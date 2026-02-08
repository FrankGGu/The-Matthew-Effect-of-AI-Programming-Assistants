impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn check_inclusion(s1: String, s2: String) -> bool {
        if s1.len() > s2.len() {
            return false;
        }

        let mut s1_count = [0; 26];
        let mut s2_count = [0; 26];

        for c in s1.chars() {
            s1_count[(c as u8 - b'a') as usize] += 1;
        }

        for i in 0..s1.len() {
            let c = s2.chars().nth(i).unwrap();
            s2_count[(c as u8 - b'a') as usize] += 1;
        }

        if s1_count == s2_count {
            return true;
        }

        for i in s1.len()..s2.len() {
            let out = s2.chars().nth(i - s1.len()).unwrap();
            s2_count[(out as u8 - b'a') as usize] -= 1;

            let in_char = s2.chars().nth(i).unwrap();
            s2_count[(in_char as u8 - b'a') as usize] += 1;

            if s1_count == s2_count {
                return true;
            }
        }

        false
    }
}
}