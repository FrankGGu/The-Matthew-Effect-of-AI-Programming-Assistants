struct Solution;

impl Solution {
    pub fn stone_game_ii(a: Vec<i32>) -> i32 {
        let n = a.len();
        let mut dp = vec![vec![0; n]; n];
        let mut suffix_sum = vec![0; n];
        suffix_sum[n - 1] = a[n - 1];
        for i in (0..n - 1).rev() {
            suffix_sum[i] = a[i] + suffix_sum[i + 1];
        }

        for i in 0..n {
            dp[i][i] = a[i];
        }

        for length in 2..=n {
            for i in 0..n - length + 1 {
                let j = i + length - 1;
                let max_val = 0;
                for k in i..j {
                    let take = suffix_sum[i] - suffix_sum[k + 1];
                    let next = dp[k + 1][j];
                    let current = take + next;
                    max_val = std::cmp::max(max_val, current);
                }
                dp[i][j] = max_val;
            }
        }

        dp[0][n - 1]
    }
}