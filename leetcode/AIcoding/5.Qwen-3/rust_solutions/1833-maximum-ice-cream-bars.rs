impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn max_ice_cream(mut costs: Vec<i32>, coins: i32) -> i32 {
        let mut count = 0;
        let mut remaining = coins;
        costs.sort();
        for cost in costs {
            if remaining >= cost {
                count += 1;
                remaining -= cost;
            } else {
                break;
            }
        }
        count
    }
}
}