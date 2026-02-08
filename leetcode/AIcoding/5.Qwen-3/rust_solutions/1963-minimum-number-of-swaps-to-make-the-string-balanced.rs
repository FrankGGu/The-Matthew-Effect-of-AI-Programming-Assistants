struct Solution;

impl Solution {
    pub fn min_swaps(s: String) -> i32 {
        let mut open = 0;
        let mut close = 0;
        for c in s.chars() {
            if c == '[' {
                open += 1;
            } else {
                close += 1;
            }
            if close > open {
                open += 1;
                close -= 1;
            }
        }
        (open - close) / 2
    }
}