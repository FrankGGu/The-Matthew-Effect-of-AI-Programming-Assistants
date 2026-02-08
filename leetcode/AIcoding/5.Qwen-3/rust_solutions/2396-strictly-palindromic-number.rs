struct Solution;

impl Solution {
    pub fn is_strictly_palindromic(_x: i32) -> bool {
        fn is_palindrome(s: &str) -> bool {
            s == s.chars().rev().collect::<String>()
        }

        for base in 2..=9 {
            let mut n = _x;
            let mut digits = String::new();
            while n > 0 {
                digits.push((n % base as i32 + b'0') as char);
                n /= base as i32;
            }
            if !is_palindrome(&digits) {
                return false;
            }
        }
        true
    }
}