impl Solution {

use std::cmp::min;

impl Solution {
    pub fn profitable_schemes(mut group: Vec<i32>, mut profit: Vec<i32>, mut max_profit: i32) -> i32 {
        let n = group.len();
        let mut dp = vec![vec![0; (max_profit + 1) as usize]; n + 1];

        for i in 0..n {
            dp[i + 1][0] = 1;
        }

        for i in 0..n {
            let g = group[i] as usize;
            let p = profit[i] as usize;
            for j in (0..=n).rev() {
                for k in 0..=max_profit {
                    if j >= i {
                        dp[j + 1][k] = (dp[j + 1][k] + dp[j][min(k as usize, p) as usize]) % 1000000007;
                    }
                }
            }
        }

        dp[n][min(max_profit as usize, profit.iter().sum::<i32>() as usize)]
    }
}

struct Solution;
}