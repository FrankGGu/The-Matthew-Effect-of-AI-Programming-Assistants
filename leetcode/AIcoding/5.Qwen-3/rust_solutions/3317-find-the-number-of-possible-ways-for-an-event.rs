impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_ways(n: i32, k: i32) -> i32 {
        if n == 0 {
            return 0;
        }
        if n == 1 {
            return k;
        }
        let mut dp = vec![0; n as usize];
        dp[0] = k;
        dp[1] = k * (k - 1);
        for i in 2..n as usize {
            dp[i] = (dp[i - 1] + dp[i - 2]) * (k - 1);
        }
        dp[n as usize - 1]
    }
}
}