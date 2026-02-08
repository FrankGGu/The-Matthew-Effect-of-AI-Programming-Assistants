struct Solution;

impl Solution {
    pub fn break_palindrome(mut s: String) -> String {
        let n = s.len();
        if n == 1 {
            return String::new();
        }
        let mut chars: Vec<char> = s.chars().collect();
        for i in 0..n / 2 {
            if chars[i] != 'a' {
                chars[i] = 'a';
                return chars.into_iter().collect();
            }
        }
        chars[n - 1] = 'b';
        chars.into_iter().collect()
    }
}