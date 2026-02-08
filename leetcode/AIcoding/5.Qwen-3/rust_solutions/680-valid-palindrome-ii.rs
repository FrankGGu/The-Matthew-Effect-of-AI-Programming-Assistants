struct Solution;

impl Solution {
    pub fn is_valid_palindrome(s: String) -> bool {
        let mut left = 0;
        let mut right = s.len() - 1;

        while left < right {
            if s.as_bytes()[left] != s.as_bytes()[right] {
                return Self::is_palindrome(&s, left + 1, right) || Self::is_palindrome(&s, left, right - 1);
            }
            left += 1;
            right -= 1;
        }

        true
    }

    fn is_palindrome(s: &str, left: usize, right: usize) -> bool {
        let bytes = s.as_bytes();
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