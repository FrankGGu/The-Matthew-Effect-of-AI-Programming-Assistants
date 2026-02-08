impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn two_city_scheduling(costs: Vec<Vec<i32>>) -> i32 {
        let mut costs = costs;
        costs.sort_by(|a, b| {
            let diff_a = a[0] - a[1];
            let diff_b = b[0] - b[1];
            diff_a.cmp(&diff_b)
        });

        let mut total = 0;
        for i in 0..costs.len() {
            if i < costs.len() / 2 {
                total += costs[i][0];
            } else {
                total += costs[i][1];
            }
        }

        total
    }
}
}