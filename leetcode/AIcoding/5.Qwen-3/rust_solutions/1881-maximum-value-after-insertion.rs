struct Solution;

impl Solution {
    pub fn maximum_value(s: String) -> i32 {
        let mut max_val = 0;
        let mut current = 0;
        for c in s.chars() {
            if c.is_ascii_digit() {
                current = current * 10 + (c as i32 - '0' as i32);
                max_val = std::cmp::max(max_val, current);
            } else {
                current = 0;
            }
        }
        max_val
    }
}