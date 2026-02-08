impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn min_changes(k: i32, s: String) -> i32 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let mut dp = vec![vec![0; n]; n];

        for len in 2..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                if s[i] == s[j] {
                    dp[i][j] = dp[i + 1][j - 1];
                } else {
                    dp[i][j] = dp[i + 1][j - 1] + 1;
                }
            }
        }

        let mut res = 0;
        let mut q = VecDeque::new();
        q.push_back((0, n as i32 - 1, 0));

        while let Some((l, r, cnt)) = q.pop_front() {
            if cnt >= k {
                continue;
            }
            if l > r {
                continue;
            }
            if l == r {
                res += 1;
                continue;
            }
            let mut min_cost = i32::MAX;
            for m in l..=r {
                let cost = dp[l as usize][m as usize] + dp[m as usize + 1][r as usize];
                min_cost = min_cost.min(cost);
            }
            res += min_cost;
            q.push_back((l, m, cnt + 1));
            q.push_back((m + 1, r, cnt + 1));
        }

        res
    }
}
}