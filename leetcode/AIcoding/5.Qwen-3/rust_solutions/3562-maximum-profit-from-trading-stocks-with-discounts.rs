impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_profit(prices: Vec<i32>, discount: i32) -> i32 {
        let n = prices.len();
        let mut memo = HashMap::new();

        fn dp(i: usize, has_stock: bool, prices: &[i32], discount: i32, memo: &mut HashMap<(usize, bool), i32>) -> i32 {
            if i == prices.len() {
                return 0;
            }
            if let Some(&val) = memo.get(&(i, has_stock)) {
                return val;
            }

            let mut res = dp(i + 1, has_stock, prices, discount, memo);

            if has_stock {
                let profit = prices[i] - discount;
                res = res.max(dp(i + 1, false, prices, discount, memo) + profit);
            } else {
                res = res.max(dp(i + 1, true, prices, discount, memo) - prices[i]);
            }

            memo.insert((i, has_stock), res);
            res
        }

        dp(0, false, &prices, discount, &mut memo)
    }
}
}