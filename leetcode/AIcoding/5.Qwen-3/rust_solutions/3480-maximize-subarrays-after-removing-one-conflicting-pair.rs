impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_remove_pairs(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut map = HashMap::new();
        let mut dp = vec![0; n];
        let mut max_len = 0;

        for i in 0..n {
            if let Some(&j) = map.get(&arr[i]) {
                dp[i] = dp[j - 1] + 2;
                max_len = std::cmp::max(max_len, dp[i]);
            }
            map.insert(arr[i], i);
        }

        max_len
    }
}
}