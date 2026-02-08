impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn judge_point24(mut nums: Vec<i32>) -> bool {
        fn dfs(nums: Vec<f64>) -> bool {
            if nums.len() == 1 {
                return (nums[0] - 24.0).abs() < 1e-6;
            }
            for i in 0..nums.len() {
                for j in 0..nums.len() {
                    if i != j {
                        let mut next = Vec::new();
                        for k in 0..nums.len() {
                            if k != i && k != j {
                                next.push(nums[k]);
                            }
                        }
                        for val in [nums[i] + nums[j], nums[i] - nums[j], nums[j] - nums[i], nums[i] * nums[j]] {
                            next.push(val as f64);
                            if dfs(next.clone()) {
                                return true;
                            }
                            next.pop();
                        }
                        if nums[j] != 0.0 {
                            next.push(nums[i] / nums[j] as f64);
                            if dfs(next.clone()) {
                                return true;
                            }
                            next.pop();
                        }
                    }
                }
            }
            false
        }
        dfs(nums.into_iter().map(|x| x as f64).collect())
    }
}
}