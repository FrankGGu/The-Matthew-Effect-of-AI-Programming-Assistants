impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn final_prices(mut prices: Vec<i32>) -> Vec<i32> {
        let n = prices.len();
        let mut stack = VecDeque::new();

        for i in 0..n {
            while let Some(&j) = stack.back() {
                if prices[j] >= prices[i] {
                    break;
                }
                stack.pop_back();
                prices[j] -= prices[i];
            }
            stack.push_back(i);
        }

        prices
    }
}

pub struct Solution;
}