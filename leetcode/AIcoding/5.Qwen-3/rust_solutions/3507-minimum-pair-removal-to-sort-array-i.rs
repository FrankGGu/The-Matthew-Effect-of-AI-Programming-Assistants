impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn min_removal_to_sort(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut dp = vec![1; n];

        for i in 0..n {
            for j in 0..i {
                if arr[j] <= arr[i] {
                    dp[i] = dp[i].max(dp[j] + 1);
                }
            }
        }

        let max_len = *dp.iter().max().unwrap();
        (n as i32 - max_len)
    }
}
}