impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn color_the_array(n: i32, k: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let mut dp = vec![vec![0; k + 1]; n];
        let mut count = 0;
        let mut map = HashMap::new();

        for i in 0..n {
            map.insert(i, 0);
        }

        for i in 0..n {
            for j in 0..=k {
                if i == 0 {
                    if j == 0 {
                        dp[i][j] = 1;
                    } else {
                        dp[i][j] = 0;
                    }
                } else {
                    for m in 0..=k {
                        if m != j {
                            dp[i][j] += dp[i - 1][m];
                        }
                    }
                }
            }
        }

        for i in 0..n {
            count += dp[i][k];
        }

        count as i32
    }
}
}