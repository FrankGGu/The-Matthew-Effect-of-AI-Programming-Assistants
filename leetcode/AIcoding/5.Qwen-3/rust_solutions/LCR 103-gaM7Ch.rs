impl Solution {

use std::cmp;

impl Solution {
    pub fn coin_change(mut coins: Vec<i32>, amount: i32) -> i32 {
        let amount = amount as usize;
        let mut dp = vec![amount + 1; amount + 1];
        dp[0] = 0;

        for &coin in &coins {
            let coin = coin as usize;
            for i in coin..=amount {
                dp[i] = cmp::min(dp[i], dp[i - coin] + 1);
            }
        }

        if dp[amount] > amount {
            -1
        } else {
            dp[amount] as i32
        }
    }
}

pub struct Solution;
}