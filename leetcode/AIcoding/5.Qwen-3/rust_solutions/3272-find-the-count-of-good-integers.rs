impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn count_good_integers(n: i32) -> i32 {
        let mut set = HashSet::new();
        for i in 0..=n {
            let s = i.to_string();
            if s.chars().all(|c| c.is_ascii_digit()) && s.len() == 1 {
                set.insert(i);
            } else {
                let mut valid = true;
                for c in s.chars() {
                    if !c.is_ascii_digit() || c == '0' {
                        valid = false;
                        break;
                    }
                }
                if valid {
                    set.insert(i);
                }
            }
        }
        set.len() as i32
    }
}
}