struct Solution;

impl Solution {
    pub fn remove_palindromic_subsequences(s: String) -> i32 {
        if s.is_empty() {
            return 0;
        }
        let is_palindrome = |s: &str| s == s.chars().rev().collect::<String>();
        if is_palindrome(&s) {
            return 1;
        }
        2
    }
}