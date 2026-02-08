impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_cost_to_equalize_array(nums: Vec<i32>, cost: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut total = 0;
        let mut sum = 0;
        for (&num, &count) in &freq {
            total += count;
            sum += num * count;
        }

        let mut res = i64::MAX;
        let mut left_sum = 0;
        let mut left_count = 0;
        let mut right_sum = sum;
        let mut right_count = total;

        for (&num, &count) in &freq {
            right_sum -= num * count;
            right_count -= count;

            let left_cost = (left_sum - num * left_count) as i64;
            let right_cost = (right_sum - num * right_count) as i64;
            let current_cost = left_cost.abs() + right_cost.abs();

            res = res.min(current_cost);
            left_sum += num * count;
            left_count += count;
        }

        res as i32
    }
}
}