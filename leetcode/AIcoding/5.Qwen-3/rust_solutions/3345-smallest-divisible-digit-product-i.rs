struct Solution;

impl Solution {
    pub fn smallest_number(n: i32) -> i32 {
        if n == 0 {
            return 0;
        }
        let mut result = 1;
        for i in 2..=9 {
            while n % i == 0 {
                result *= i;
                n /= i;
            }
        }
        if n > 1 {
            result *= n;
        }
        result
    }
}