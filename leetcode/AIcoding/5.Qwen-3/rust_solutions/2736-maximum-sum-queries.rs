impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn maximum_sum_queries(queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut nums = vec![];
        for q in &queries {
            nums.push(q[0]);
        }
        nums.sort();
        let mut map = HashMap::new();
        for num in &nums {
            map.insert(*num, *num);
        }
        let mut sorted_nums = nums.clone();
        sorted_nums.sort_unstable();
        let mut dp = vec![0; sorted_nums.len()];
        for i in (0..sorted_nums.len()).rev() {
            let mut max_val = 0;
            for j in i + 1..sorted_nums.len() {
                if sorted_nums[j] % sorted_nums[i] == 0 {
                    max_val = std::cmp::max(max_val, dp[j]);
                }
            }
            dp[i] = max_val + sorted_nums[i];
        }
        let mut result = vec![];
        for q in queries {
            let x = q[0];
            let y = q[1];
            let mut res = -1;
            for i in 0..sorted_nums.len() {
                if sorted_nums[i] >= x && sorted_nums[i] <= y {
                    res = std::cmp::max(res, dp[i]);
                }
            }
            result.push(res);
        }
        result
    }
}
}