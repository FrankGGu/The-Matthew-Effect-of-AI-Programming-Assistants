struct Solution;

impl Solution {
    pub fn my_atoi(s: String) -> i32 {
        let s = s.trim();
        if s.is_empty() {
            return 0;
        }

        let mut sign = 1;
        let mut i = 0;

        if s.chars().nth(0) == Some('-') {
            sign = -1;
            i += 1;
        } else if s.chars().nth(0) == Some('+') {
            i += 1;
        }

        let mut result = 0;

        while i < s.len() {
            let c = s.chars().nth(i).unwrap();
            if !c.is_digit(10) {
                break;
            }

            let digit = c.to_digit(10).unwrap() as i32;
            result = result.saturating_mul(10).saturating_add(digit);

            i += 1;
        }

        result * sign
    }
}