impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn letter_case_permutation(s: String) -> Vec<String> {
        let mut result = Vec::new();
        let mut queue = VecDeque::new();
        queue.push_back(s);

        while let Some(current) = queue.pop_front() {
            if current.len() == 0 {
                result.push(current);
                continue;
            }
            let chars: Vec<char> = current.chars().collect();
            let first_char = chars[0];
            if first_char.is_ascii_digit() {
                queue.push_back(current);
            } else {
                let lower = format!("{}{}", first_char.to_ascii_lowercase(), &current[1..]);
                let upper = format!("{}{}", first_char.to_ascii_uppercase(), &current[1..]);
                queue.push_back(lower);
                queue.push_back(upper);
            }
        }

        result
    }
}
}