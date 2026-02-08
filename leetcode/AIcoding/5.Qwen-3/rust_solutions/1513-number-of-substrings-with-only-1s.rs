struct Solution;

impl Solution {
    pub fn num_sub(s: String) -> i32 {
        let mut count = 0;
        let mut consecutive_ones = 0;

        for c in s.chars() {
            if c == '1' {
                consecutive_ones += 1;
                count += consecutive_ones;
            } else {
                consecutive_ones = 0;
            }
        }

        count as i32
    }
}