impl Solution {

use std::cmp::Reverse;

impl Solution {
    pub fn max_coins(mut piles: Vec<i32>) -> i32 {
        piles.sort_by_key(|&x| Reverse(x));
        let mut result = 0;
        for i in 1..piles.len() - 1 {
            if i % 2 == 1 {
                result += piles[i];
            }
        }
        result
    }
}
}