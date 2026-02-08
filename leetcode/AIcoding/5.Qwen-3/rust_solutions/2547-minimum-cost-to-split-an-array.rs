impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn min_cost_to_split_array(nums: Vec<i32>, cost: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut pairs = Vec::with_capacity(n);
        for i in 0..n {
            pairs.push((nums[i], cost[i]));
        }
        pairs.sort_by(|a, b| a.0.cmp(&b.0));

        let mut total_cost = 0;
        let mut left_sum = 0;
        let mut right_sum = 0;

        for i in 1..n {
            right_sum += pairs[i].1;
        }

        for i in 1..n {
            left_sum += pairs[i - 1].1;
            right_sum -= pairs[i].1;
            match pairs[i].0.cmp(&pairs[i - 1].0) {
                Ordering::Equal => {}
                _ => {
                    total_cost += left_sum * (pairs[i].0 - pairs[i - 1].0);
                    total_cost += right_sum * (pairs[i].0 - pairs[i - 1].0);
                }
            }
        }

        total_cost
    }
}
}