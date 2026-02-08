impl Solution {

use std::cmp::max;

impl Solution {
    pub fn max_profit_sell(prices: Vec<i32>, sale_prices: Vec<i32>) -> i32 {
        let mut dp = vec![0; prices.len()];
        let mut map = std::collections::HashMap::new();

        for (i, &price) in prices.iter().enumerate() {
            map.insert(price, i);
        }

        for i in 1..prices.len() {
            let mut max_val = 0;
            for j in 0..i {
                if prices[j] < prices[i] {
                    max_val = max(max_val, dp[j] + sale_prices[i]);
                }
            }
            dp[i] = max_val;
        }

        *dp.last().unwrap()
    }
}
}