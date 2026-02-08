impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn distinct_squares(s: String) -> i32 {
        let mut set = HashSet::new();
        for i in 0..s.len() {
            for j in i+1..s.len() {
                let substr = &s[i..j+1];
                let sqrt = (substr.len() as f64).sqrt();
                if sqrt.fract() == 0.0 {
                    set.insert(substr);
                }
            }
        }
        set.len() as i32
    }
}
}