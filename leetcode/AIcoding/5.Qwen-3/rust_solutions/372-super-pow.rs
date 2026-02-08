struct Solution;

impl Solution {
    pub fn super_pow(a: i32, b: Vec<i32>) -> i32 {
        let mod_val = 1000000007;
        let mut result = 1;
        for &digit in &b {
            result = (result * pow(a, digit as i32)) % mod_val;
        }
        result
    }

    fn pow(mut a: i32, mut n: i32) -> i32 {
        let mod_val = 1000000007;
        let mut result = 1;
        a = a % mod_val;
        while n > 0 {
            if n % 2 == 1 {
                result = (result * a) % mod_val;
            }
            a = (a * a) % mod_val;
            n /= 2;
        }
        result
    }
}