struct Solution;

impl Solution {
    pub fn can_be_valid(s: String) -> bool {
        if s.len() % 2 != 0 {
            return false;
        }
        let mut open = 0;
        let mut close = 0;
        for c in s.chars() {
            if c == '(' {
                open += 1;
            } else {
                close += 1;
            }
            if close > open {
                return false;
            }
        }
        open == close
    }
}