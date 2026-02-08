impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn number_of_good_subsets(nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for num in nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31];
        let mut dp = vec![0; 1 << primes.len()];
        dp[0] = 1;

        for (num, &count) in &freq {
            if *num == 1 {
                continue;
            }
            let mut mask = 0;
            let mut n = *num;
            let mut valid = true;
            for (i, &p) in primes.iter().enumerate() {
                if n % p == 0 {
                    n /= p;
                    mask |= 1 << i;
                }
            }
            if n != 1 {
                continue;
            }
            for i in (0..1 << primes.len()).rev() {
                if dp[i] > 0 && (i & mask) == 0 {
                    dp[i | mask] = (dp[i | mask] + dp[i] * count) as i32;
                }
            }
        }

        let mut result = 0;
        for i in 1..(1 << primes.len()) {
            result = (result + dp[i]) as i32;
        }

        result
    }
}
}