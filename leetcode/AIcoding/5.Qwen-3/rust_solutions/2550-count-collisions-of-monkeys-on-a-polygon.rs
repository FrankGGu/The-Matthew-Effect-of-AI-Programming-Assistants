impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn monkey_moves(mut n: i32) -> i32 {
        let mod_val = 10i64.pow(9) + 7;
        let mut result = 1i64;
        for _ in 0..n {
            result = (result * 2) % mod_val;
        }
        result = (result - 2) % mod_val;
        if result < 0 {
            result += mod_val;
        }
        result as i32
    }
}
}