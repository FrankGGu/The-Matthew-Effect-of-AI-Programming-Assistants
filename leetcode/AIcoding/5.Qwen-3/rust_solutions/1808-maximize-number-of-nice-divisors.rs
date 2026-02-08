impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_nice_divisors(mut n: i32) -> i32 {
        const MOD: i64 = 1_000_000_007;

        if n == 1 {
            return 1;
        }

        let mut factors = HashMap::new();
        let mut m = n;
        let mut i = 2;
        while i * i <= m {
            while m % i == 0 {
                *factors.entry(i).or_insert(0) += 1;
                m /= i;
            }
            i += 1;
        }
        if m > 1 {
            *factors.entry(m).or_insert(0) += 1;
        }

        let mut result = 1;
        for &count in factors.values() {
            result = (result * pow(3, count as i64, MOD)) % MOD;
        }

        result
    }

    fn pow(base: i64, exponent: i64, mod_val: i64) -> i64 {
        let mut result = 1;
        let mut exp = exponent;
        let mut b = base;
        while exp > 0 {
            if exp % 2 == 1 {
                result = (result * b) % mod_val;
            }
            b = (b * b) % mod_val;
            exp /= 2;
        }
        result
    }
}
}