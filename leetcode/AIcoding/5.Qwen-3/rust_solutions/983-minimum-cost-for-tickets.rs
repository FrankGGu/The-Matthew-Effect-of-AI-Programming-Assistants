impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn min_cost_tickets(mut costs: Vec<i32>, mut days: Vec<i32>) -> i32 {
        let mut dp = vec![0; days.len()];
        let mut day_set: HashSet<i32> = days.iter().cloned().collect();
        let mut last_day = days[days.len() - 1];

        for i in 0..days.len() {
            if days[i] > last_day {
                break;
            }
            let mut cost = i32::MAX;
            for j in 0..3 {
                let duration = match j {
                    0 => 1,
                    1 => 7,
                    2 => 30,
                    _ => 0,
                };
                let prev_day = days[i] - duration;
                let mut prev_index = i;
                while prev_index > 0 && days[prev_index - 1] >= prev_day {
                    prev_index -= 1;
                }
                if prev_index == 0 {
                    cost = std::cmp::min(cost, costs[j]);
                } else {
                    cost = std::cmp::min(cost, dp[prev_index - 1] + costs[j]);
                }
            }
            dp[i] = cost;
        }

        dp[dp.len() - 1]
    }
}
}