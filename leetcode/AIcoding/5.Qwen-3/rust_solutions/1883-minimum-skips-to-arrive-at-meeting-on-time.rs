impl Solution {

use std::cmp::Ordering;
use std::collections::VecDeque;

impl Solution {
    pub fn min_skips(target_time: i32, forward: Vec<i32>, backward: Vec<i32>) -> i32 {
        let n = forward.len();
        let mut dp = vec![vec![i32::MAX; n + 1]; n + 1];
        dp[0][0] = 0;

        for i in 0..n {
            for k in 0..=i {
                if dp[i][k] == i32::MAX {
                    continue;
                }
                let time = dp[i][k] + forward[i];
                match time.cmp(&target_time) {
                    Ordering::Less => {
                        dp[i + 1][k] = dp[i + 1][k].min(time);
                    }
                    _ => {}
                }
                let time = dp[i][k] + forward[i] + backward[i];
                if time < target_time {
                    dp[i + 1][k + 1] = dp[i + 1][k + 1].min(time);
                }
            }
        }

        for k in 0..=n {
            if dp[n][k] < target_time {
                return k as i32;
            }
        }
        -1
    }
}
}