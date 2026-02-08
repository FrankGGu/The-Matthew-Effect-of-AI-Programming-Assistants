impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn number_diff_integers(s: String) -> i32 {
        let mut set = HashSet::new();
        let mut num = String::new();
        let mut in_num = false;

        for c in s.chars() {
            if c.is_ascii_digit() {
                num.push(c);
                in_num = true;
            } else if in_num {
                set.insert(num.clone());
                num.clear();
                in_num = false;
            }
        }

        if in_num {
            set.insert(num);
        }

        set.len() as i32
    }
}
}