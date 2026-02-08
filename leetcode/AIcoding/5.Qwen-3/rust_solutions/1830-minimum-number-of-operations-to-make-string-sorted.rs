impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn get_min_operations(s: String) -> i32 {
        let mod_val = 1000000007;
        let mut fact = vec![1; 26];
        for i in 1..26 {
            fact[i] = fact[i - 1] * i % mod_val;
        }

        let mut freq = vec![0; 26];
        for c in s.chars() {
            freq[c as usize - 'a' as usize] += 1;
        }

        let mut res = 0;
        let mut n = s.len() as i32;
        for i in (0..s.len()).rev() {
            let c = s.as_bytes()[i] as usize - 'a' as usize;
            let mut count = 0;
            for j in 0..c {
                count += freq[j];
            }
            res = (res + count * fact[n - 1] % mod_val) % mod_val;
            freq[c] -= 1;
            n -= 1;
        }

        res
    }
}
}