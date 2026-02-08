impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_anagrams(s: String) -> i32 {
        const MOD: i32 = 1000000007;

        let mut fact = vec![1; s.len() + 1];
        for i in 1..=s.len() {
            fact[i] = fact[i - 1] * i as i32 % MOD;
        }

        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut result = fact[s.len()];
        for &count in freq.values() {
            result = result * modinv(fact[count], MOD) % MOD;
        }

        result
    }

    fn modinv(a: i32, mod_val: i32) -> i32 {
        pow(a, mod_val - 2, mod_val)
    }

    fn pow(mut a: i32, mut b: i32, mod_val: i32) -> i32 {
        let mut result = 1;
        a %= mod_val;
        while b > 0 {
            if b % 2 == 1 {
                result = result * a % mod_val;
            }
            a = a * a % mod_val;
            b /= 2;
        }
        result
    }
}
}