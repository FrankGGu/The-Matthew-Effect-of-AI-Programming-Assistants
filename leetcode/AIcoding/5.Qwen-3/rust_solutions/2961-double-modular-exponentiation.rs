struct Solution {}

impl Solution {
    pub fn pow_mod(mut x: i32, mut n: i32, mod_val: i32) -> i32 {
        let mut result = 1;
        x = x % mod_val;
        while n > 0 {
            if n % 2 == 1 {
                result = (result * x) % mod_val;
            }
            x = (x * x) % mod_val;
            n = n / 2;
        }
        result
    }

    pub fn double_modular_exponentiation(a: i32, b: i32, c: i32, d: i32, e: i32) -> i32 {
        let temp = Self::pow_mod(a, b, c);
        Self::pow_mod(temp, d, e)
    }
}