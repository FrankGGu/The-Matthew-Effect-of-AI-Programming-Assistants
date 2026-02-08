struct Solution;

impl Solution {
    pub fn divide(dividend: i32, divisor: i32) -> i32 {
        if dividend == i32::MIN && divisor == -1 {
            return i32::MAX;
        }

        let mut dividend = dividend as i64;
        let mut divisor = divisor as i64;
        let mut result = 0;
        let negative = (dividend < 0) != (divisor < 0);

        dividend = dividend.abs();
        divisor = divisor.abs();

        while dividend >= divisor {
            let mut temp = divisor;
            let mut multiple = 1;
            while dividend >= temp << 1 {
                temp <<= 1;
                multiple <<= 1;
            }
            dividend -= temp;
            result += multiple;
        }

        if negative {
            -result as i32
        } else {
            result as i32
        }
    }
}