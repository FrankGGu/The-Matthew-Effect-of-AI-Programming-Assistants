impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn coin_bonus(n: i32, k: i32, coins: Vec<i32>) -> i32 {
        let mut map = HashMap::new();
        for &coin in &coins {
            *map.entry(coin).or_insert(0) += 1;
        }

        let mut total = 0;
        for (coin, count) in map {
            if count >= k {
                total += (count / k) * coin;
            }
        }

        total
    }
}
}