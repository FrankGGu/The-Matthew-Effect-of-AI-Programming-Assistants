impl Solution {

use std::cmp::Ordering;
use std::collections::VecDeque;

impl Solution {
    pub fn best_team_with_no_conflicts(mut people: Vec<Vec<i32>>) -> i32 {
        people.sort_by(|a, b| match a[0].cmp(&b[0]) {
            Ordering::Equal => a[1].cmp(&b[1]),
            other => other,
        });

        let mut dp = vec![0; people.len()];
        let mut max_score = 0;

        for i in 0..people.len() {
            dp[i] = people[i][1];
            for j in 0..i {
                if people[i][1] >= people[j][1] {
                    dp[i] = std::cmp::max(dp[i], dp[j] + people[i][1]);
                }
            }
            max_score = std::cmp::max(max_score, dp[i]);
        }

        max_score
    }
}
}