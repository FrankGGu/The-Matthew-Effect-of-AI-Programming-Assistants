impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn minimum_coins_to_add(mut coins: Vec<i32>, target: i32) -> i32 {
        coins.sort();
        let mut res = 0;
        let mut curr = 1;
        let mut i = 0;
        while curr <= target {
            if i < coins.len() && coins[i] <= curr {
                curr += coins[i];
                i += 1;
            } else {
                res += 1;
                curr += curr;
            }
        }
        res
    }
}
}