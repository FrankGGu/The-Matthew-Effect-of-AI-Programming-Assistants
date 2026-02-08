impl Solution {

use std::vec::Vec;

impl Solution {
    pub fn read_binary_watch(num: i32) -> Vec<String> {
        let mut result = Vec::new();
        for h in 0..12 {
            for m in 0..60 {
                if (h.count_ones() + m.count_ones()) as i32 == num {
                    result.push(format!("{}:{:02}", h, m));
                }
            }
        }
        result
    }
}

pub struct Solution;
}