impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn min_cost_to_make_histogram_equalized(heights: Vec<i32>, cost: Vec<i32>) -> i32 {
        let n = heights.len();
        let mut dp = vec![0; n];
        let mut map = HashMap::new();

        for i in 0..n {
            map.insert(heights[i], i);
        }

        for i in 1..n {
            dp[i] = dp[i - 1] + (heights[i] - heights[i - 1]) * cost[i - 1];
        }

        for i in 1..n {
            let prev = heights[i - 1];
            let curr = heights[i];
            if prev > curr {
                dp[i] = dp[i - 1] + (prev - curr) * cost[i - 1];
            }
        }

        dp[n - 1]
    }
}
}