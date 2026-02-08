impl Solution {

use std::vec::Vec;

impl Solution {
    pub fn valid_strings(n: i32) -> Vec<String> {
        let mut result = Vec::new();
        let mut current = String::with_capacity(n as usize);
        Self::backtrack(n, &mut result, &mut current, 0);
        result
    }

    fn backtrack(n: i32, result: &mut Vec<String>, current: &mut String, pos: i32) {
        if pos == n {
            result.push(current.clone());
            return;
        }

        if pos == 0 || current.chars().last() != Some('1') {
            current.push('0');
            Self::backtrack(n, result, current, pos + 1);
            current.pop();
        }

        current.push('1');
        Self::backtrack(n, result, current, pos + 1);
        current.pop();
    }
}
}