impl Solution {

use std::f64;

struct Solution {}

impl Solution {
    pub fn best_position(houses: Vec<i32>, k: i32) -> i32 {
        let mut houses = houses;
        houses.sort();
        let n = houses.len();
        let k = k as usize;

        let mut dp = vec![vec![0; k + 1]; n];
        let mut cost = vec![vec![0; n]; n];

        for i in 0..n {
            for j in i..n {
                let median = houses[(i + j) / 2];
                for m in i..=j {
                    cost[i][j] += (houses[m] - median).abs();
                }
            }
        }

        for i in 0..n {
            dp[i][1] = cost[0][i];
        }

        for j in 2..=k {
            for i in 0..n {
                dp[i][j] = f64::INFINITY as i32;
                for m in 0..i {
                    dp[i][j] = dp[i][j].min(dp[m][j - 1] + cost[m + 1][i]);
                }
            }
        }

        dp[n - 1][k]
    }
}
}