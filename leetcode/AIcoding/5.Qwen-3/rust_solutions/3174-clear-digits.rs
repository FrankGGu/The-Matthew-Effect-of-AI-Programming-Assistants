impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn clear_digits(s: String) -> String {
        let mut stack = VecDeque::new();
        for c in s.chars() {
            if c.is_ascii_digit() {
                if let Some(last_char) = stack.back_mut() {
                    if last_char.is_ascii_digit() {
                        *last_char = c;
                    } else {
                        stack.push_back(c);
                    }
                } else {
                    stack.push_back(c);
                }
            } else {
                stack.push_back(c);
            }
        }
        stack.into_iter().collect()
    }
}
}