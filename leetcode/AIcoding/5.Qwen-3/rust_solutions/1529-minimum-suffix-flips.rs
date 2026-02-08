struct Solution;

impl Solution {
    pub fn min_changes(s: String) -> i32 {
        let mut count = 0;
        let mut prev = '0';

        for c in s.chars() {
            if c != prev {
                count += 1;
                prev = c;
            }
        }

        count
    }
}