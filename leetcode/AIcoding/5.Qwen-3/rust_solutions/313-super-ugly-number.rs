struct Solution;

impl Solution {
    pub fn nth_super_ugly_number(n: i32, primes: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut dp = vec![1; n];
        let mut pointers = vec![0; primes.len()];
        let mut next = vec![0; primes.len()];

        for i in 0..primes.len() {
            next[i] = primes[i];
        }

        for i in 1..n {
            let mut min_val = i32::MAX;
            for j in 0..primes.len() {
                if next[j] < min_val {
                    min_val = next[j];
                }
            }
            dp[i] = min_val;

            for j in 0..primes.len() {
                if next[j] == min_val {
                    pointers[j] += 1;
                    next[j] = dp[pointers[j]] * primes[j];
                }
            }
        }

        dp[n - 1]
    }
}