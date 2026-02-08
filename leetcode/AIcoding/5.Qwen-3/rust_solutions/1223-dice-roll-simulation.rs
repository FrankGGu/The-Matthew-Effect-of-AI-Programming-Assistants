impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn die_simulator(n: i32, k: i32) -> i32 {
        let mod_val = 10_i64.pow(9) + 7;
        let mut dp = vec![0; 6];
        for _ in 0..n {
            let mut new_dp = vec![0; 6];
            for i in 0..6 {
                for j in 0..6 {
                    if i != j {
                        new_dp[j] = (new_dp[j] + dp[i]) % mod_val;
                    }
                }
            }
            dp = new_dp;
        }
        dp.iter().sum::<i64>() as i32 % mod_val
    }
}
}