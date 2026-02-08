impl Solution {

use std::cmp::Ordering;

struct Solution {}

impl Solution {
    pub fn largest_sum_of_avgs(mut nums: Vec<i32>, mut k: i32) -> f64 {
        let n = nums.len();
        k = k.min(n as i32);
        let mut dp = vec![0.0; n];
        for i in 0..n {
            dp[i] = (nums[i..].iter().sum::<i32>() as f64) / (n - i) as f64;
        }
        for _ in 1..k {
            for i in 0..n {
                for j in i+1..n {
                    match dp[i].partial_cmp(&(dp[j] + (nums[i..j].iter().sum::<i32>() as f64) / (j - i) as f64)) {
                        Some(Ordering::Less) => dp[i] = dp[j] + (nums[i..j].iter().sum::<i32>() as f64) / (j - i) as f64,
                        _ => {}
                    }
                }
            }
        }
        dp[0]
    }
}
}