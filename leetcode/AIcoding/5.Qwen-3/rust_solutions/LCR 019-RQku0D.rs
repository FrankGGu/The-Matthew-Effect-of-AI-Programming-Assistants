struct Solution;

impl Solution {
    pub fn is_valid_palindrome(s: String) -> bool {
        let mut left = 0;
        let mut right = s.len() - 1;

        while left < right {
            let left_char = s.as_bytes()[left];
            let right_char = s.as_bytes()[right];

            if !is_alphanumeric(left_char) {
                left += 1;
            } else if !is_alphanumeric(right_char) {
                right -= 1;
            } else if left_char != right_char {
                return false;
            } else {
                left += 1;
                right -= 1;
            }
        }

        true
    }
}

fn is_alphanumeric(c: u8) -> bool {
    (c >= b'a' && c <= b'z') || (c >= b'A' && c <= b'Z') || (c >= b'0' && c <= b'9')
}