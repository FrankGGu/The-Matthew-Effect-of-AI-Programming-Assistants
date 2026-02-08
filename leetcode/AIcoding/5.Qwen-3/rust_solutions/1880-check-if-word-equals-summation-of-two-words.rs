impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn is_sum_equal(s: String, t: String) -> bool {
        fn word_to_num(word: &str) -> i32 {
            let mut num = 0;
            for c in word.chars() {
                num = num * 10 + (c as u8 - b'a' + 1) as i32;
            }
            num
        }
        word_to_num(&s) == word_to_num(&t)
    }
}
}