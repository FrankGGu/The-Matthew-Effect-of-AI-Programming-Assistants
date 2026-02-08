impl Solution {
    pub fn max_profit(k: i32, prices: Vec<i32>) -> i32 {
        if prices.len() < 2 {
            return 0;
        }
        if k >= prices.len() / 2 {
            let mut max_profit = 0;
            for i in 1..prices.len() {
                if prices[i] > prices[i - 1] {
                    max_profit += prices[i] - prices[i - 1];
                }
            }
            return max_profit;
        }
        let mut dp = vec![vec![0; 2]; k as usize + 1];
        for i in 0..k as usize + 1 {
            dp[i][0] = -prices[0];
        }
        for i in 1..prices.len() {
            for j in 1..=k as usize {
                dp[j][0] = dp[j][0].max(dp[j - 1][1] - prices[i]);
                dp[j][1] = dp[j][1].max(dp[j][0] + prices[i]);
            }
        }
        dp[k as usize][1]
    }
}