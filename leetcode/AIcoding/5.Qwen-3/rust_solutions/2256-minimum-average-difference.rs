impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn minimum_average_difference(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut total_sum: i64 = nums.iter().map(|&x| x as i64).sum();
        let mut left_sum: i64 = 0;
        let mut min_avg_diff = i64::MAX;
        let mut result = 0;

        for i in 0..n {
            left_sum += nums[i] as i64;
            let right_sum = total_sum - left_sum;
            let left_avg = left_sum as f64 / (i + 1) as f64;
            let right_avg = if i < n - 1 {
                right_sum as f64 / (n - i - 1) as f64
            } else {
                0.0
            };
            let diff = (left_avg - right_avg).abs();
            if diff < min_avg_diff {
                min_avg_diff = diff;
                result = i as i32;
            }
        }

        result
    }
}
}