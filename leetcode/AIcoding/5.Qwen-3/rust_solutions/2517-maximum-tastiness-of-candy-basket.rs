impl Solution {

use std::cmp::max;

impl Solution {
    pub fn max_tastiness(mut price: Vec<i32>, k: i32) -> i32 {
        price.sort();
        let n = price.len();
        let mut dp = vec![vec![-1; k as usize + 1]; n];

        fn dfs(i: usize, k: i32, price: &Vec<i32>, dp: &mut Vec<Vec<i32>>) -> i32 {
            if k == 0 {
                return 0;
            }
            if i >= price.len() {
                return -1;
            }
            if dp[i][k as usize] != -1 {
                return dp[i][k as usize];
            }
            let take = price[i] + dfs(i + 1, k - 1, price, dp);
            let not_take = dfs(i + 1, k, price, dp);
            dp[i][k as usize] = max(take, not_take);
            dp[i][k as usize]
        }

        dfs(0, k, &price, &mut dp)
    }
}
}