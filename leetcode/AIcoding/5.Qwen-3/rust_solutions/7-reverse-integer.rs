struct Solution;

impl Solution {
    pub fn reverse(x: i32) -> i32 {
        let mut x = x;
        let mut reversed = 0;
        while x != 0 {
            let digit = x % 10;
            x /= 10;
            reversed = reversed.checked_mul(10).and_then(|r| r.checked_add(digit)).unwrap_or(0);
        }
        reversed
    }
}