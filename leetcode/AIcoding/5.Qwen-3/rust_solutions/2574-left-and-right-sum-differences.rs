impl Solution {

use std::iter;

impl Solution {
    pub fn left_right_sum_differences(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut left_sum = 0;
        let total_sum: i32 = nums.iter().sum();
        let mut result = Vec::with_capacity(n);

        for i in 0..n {
            let right_sum = total_sum - left_sum - nums[i];
            result.push(left_sum - right_sum);
            left_sum += nums[i];
        }

        result
    }
}
}