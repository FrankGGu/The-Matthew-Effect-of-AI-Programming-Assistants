impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn min_cost(n: i32, cuts: Vec<i32>) -> i32 {
        let mut cuts = cuts;
        cuts.push(0);
        cuts.push(n);
        cuts.sort();

        let m = cuts.len();
        let mut dp = vec![vec![0; m]; m];

        for length in 2..m {
            for i in 0..m - length {
                let j = i + length;
                dp[i][j] = i32::MAX;
                for k in i + 1..j {
                    let cost = dp[i][k] + dp[k][j] + cuts[j] - cuts[i];
                    if cost < dp[i][j] {
                        dp[i][j] = cost;
                    }
                }
            }
        }

        dp[0][m - 1]
    }
}
}