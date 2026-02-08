struct Solution;

impl Solution {
    pub fn max_profit(prices: Vec<i32>) -> i32 {
        if prices.is_empty() {
            return 0;
        }

        let n = prices.len();
        let mut hold = vec![0; n];
        let mut not_hold = vec![0; n];

        hold[0] = -prices[0];

        for i in 1..n {
            hold[i] = std::cmp::max(hold[i - 1], not_hold[i - 1] - prices[i]);
            not_hold[i] = std::cmp::max(not_hold[i - 1], hold[i - 1] + prices[i]);
        }

        not_hold[n - 1]
    }
}