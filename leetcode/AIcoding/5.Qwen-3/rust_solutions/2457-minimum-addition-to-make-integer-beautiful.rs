struct Solution;

impl Solution {
    pub fn min_add_to_make_integer_beautiful(n: i64) -> i64 {
        let mut n = n;
        let mut power = 1;
        while n > 0 {
            let next_power = power * 10;
            let remainder = n % next_power;
            if remainder != 0 {
                return next_power - remainder;
            }
            power = next_power;
            n /= 10;
        }
        0
    }
}