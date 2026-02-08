struct Solution;

impl Solution {
    pub fn minimum_length(s: String) -> i32 {
        let mut left = 0;
        let mut right = s.len() - 1;

        while left < right && s.as_bytes()[left] == s.as_bytes()[right] {
            let c = s.as_bytes()[left];
            while left <= right && s.as_bytes()[left] == c {
                left += 1;
            }
            while left <= right && s.as_bytes()[right] == c {
                right -= 1;
            }
        }

        (right - left + 1) as i32
    }
}