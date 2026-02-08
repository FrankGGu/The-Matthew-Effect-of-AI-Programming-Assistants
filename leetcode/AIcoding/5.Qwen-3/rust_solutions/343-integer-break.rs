struct Solution;

impl Solution {
    pub fn integer_break(n: i32) -> i32 {
        if n == 2 {
            return 1;
        }
        if n == 3 {
            return 2;
        }
        let mut result = 1;
        let mut remaining = n;
        while remaining > 4 {
            result *= 3;
            remaining -= 3;
        }
        result *= remaining;
        result
    }
}