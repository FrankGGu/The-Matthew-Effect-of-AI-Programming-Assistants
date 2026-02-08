impl Solution {

use std::cmp::Ordering;
use std::collections::HashMap;

impl Solution {
    pub fn largest_possible_number(mut cost: Vec<i32>, target: i32) -> String {
        let mut dp = vec![vec![-1; 10]; target as usize + 1];
        for i in 0..10 {
            if cost[i] == 0 {
                dp[0][i] = 0;
            }
        }

        for t in 1..=target as usize {
            for d in 0..10 {
                if cost[d] == 0 {
                    continue;
                }
                if t >= cost[d] as usize {
                    if dp[t - cost[d] as usize][d] != -1 {
                        dp[t][d] = dp[t - cost[d] as usize][d] + 1;
                    }
                }
            }
        }

        let mut result = String::new();
        let mut remaining = target as usize;
        while remaining > 0 {
            let mut max_digit = -1;
            let mut max_count = -1;
            for d in 0..10 {
                if cost[d] == 0 {
                    continue;
                }
                if remaining >= cost[d] as usize && dp[remaining - cost[d] as usize][d] != -1 {
                    let count = dp[remaining - cost[d] as usize][d] + 1;
                    if count > max_count || (count == max_count && d > max_digit) {
                        max_count = count;
                        max_digit = d as i32;
                    }
                }
            }
            if max_digit == -1 {
                return String::new();
            }
            result.push((b'0' + max_digit as u8) as char);
            remaining -= cost[max_digit as usize] as usize;
        }

        result
    }
}
}