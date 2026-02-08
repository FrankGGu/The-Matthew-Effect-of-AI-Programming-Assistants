impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn min_cost(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut dp = vec![0; n + 1];
        for i in 1..=n {
            dp[i] = i32::MAX;
            for j in 0..i {
                let cost = Self::subarray_cost(&arr[j..i]);
                if dp[j] + cost < dp[i] {
                    dp[i] = dp[j] + cost;
                }
            }
        }
        dp[n]
    }

    fn subarray_cost(sub: &[i32]) -> i32 {
        let mut max_val = sub[0];
        let mut min_val = sub[0];
        for &num in sub.iter() {
            max_val = max_val.max(num);
            min_val = min_val.min(num);
        }
        max_val - min_val
    }
}
}