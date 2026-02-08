impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_special_subsequences(s: String) -> i32 {
        let mut a = 0;
        let mut ab = 0;
        let mut abc = 0;

        for c in s.chars() {
            match c {
                'a' => a += 1,
                'b' => ab += a,
                'c' => abc += ab,
                _ => {}
            }
        }

        abc
    }
}
}