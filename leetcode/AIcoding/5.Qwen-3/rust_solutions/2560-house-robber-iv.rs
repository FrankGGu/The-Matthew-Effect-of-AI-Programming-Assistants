impl Solution {

use std::cmp;

impl Solution {
    pub fn min_houses(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }
        if n == 1 {
            return nums[0];
        }
        let mut dp0 = 0;
        let mut dp1 = nums[0];
        for i in 1..n {
            let new_dp0 = cmp::max(dp0, dp1);
            let new_dp1 = dp0 + nums[i];
            dp0 = new_dp0;
            dp1 = new_dp1;
        }
        cmp::min(dp0, dp1)
    }
}
}