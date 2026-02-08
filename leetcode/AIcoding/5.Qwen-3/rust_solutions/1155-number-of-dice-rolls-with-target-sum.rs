impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_rolls_to_target(d: i32, f: i32, target: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let d = d as usize;
        let f = f as usize;
        let target = target as usize;

        let mut dp = vec![0; target + 1];
        dp[0] = 1;

        for _ in 0..d {
            let mut new_dp = vec![0; target + 1];
            for t in 0..=target {
                for face in 1..=f {
                    if t >= face {
                        new_dp[t] = (new_dp[t] + dp[t - face]) % MOD;
                    }
                }
            }
            dp = new_dp;
        }

        dp[target]
    }
}
}