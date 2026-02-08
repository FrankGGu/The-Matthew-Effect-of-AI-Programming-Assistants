impl Solution {

use std::vec::Vec;

struct Solution {}

impl Solution {
    pub fn partition(s: String) -> Vec<Vec<String>> {
        let mut result = Vec::new();
        let mut current = Vec::new();
        Self::backtrack(&s, 0, &mut current, &mut result);
        result
    }

    fn backtrack(s: &str, start: usize, current: &mut Vec<String>, result: &mut Vec<Vec<String>>) {
        if start == s.len() {
            result.push(current.clone());
            return;
        }

        for end in start + 1..=s.len() {
            let substring = &s[start..end];
            if Self::is_palindrome(substring) {
                current.push(substring.to_string());
                Self::backtrack(s, end, current, result);
                current.pop();
            }
        }
    }

    fn is_palindrome(s: &str) -> bool {
        let bytes = s.as_bytes();
        let mut left = 0;
        let mut right = bytes.len() - 1;
        while left < right {
            if bytes[left] != bytes[right] {
                return false;
            }
            left += 1;
            right -= 1;
        }
        true
    }
}
}