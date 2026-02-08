impl Solution {

use std::cmp::min;

struct Solution;

impl Solution {
    pub fn longest_common_prefix(mut strings: Vec<String>, k: i32) -> String {
        if strings.is_empty() || k == 0 {
            return String::new();
        }

        let k = k as usize;
        let mut prefix = String::new();

        for i in 0..strings[0].len() {
            let c = strings[0].chars().nth(i).unwrap();
            for j in 1..k {
                if i >= strings[j].len() || strings[j].chars().nth(i) != Some(c) {
                    return prefix;
                }
            }
            prefix.push(c);
        }

        prefix
    }
}
}