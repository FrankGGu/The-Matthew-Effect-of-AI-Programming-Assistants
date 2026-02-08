impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn check_valid_string(s: String) -> bool {
        let mut dp = HashSet::new();
        dp.insert(0);
        for c in s.chars() {
            let mut next_dp = HashSet::new();
            for &balance in &dp {
                match c {
                    '(' => next_dp.insert(balance + 1),
                    ')' => next_dp.insert(balance - 1),
                    '*' => {
                        next_dp.insert(balance + 1);
                        next_dp.insert(balance);
                        next_dp.insert(balance - 1)
                    }
                    _ => false,
                };
            }
            dp = next_dp;
        }
        dp.contains(&0)
    }
}
}