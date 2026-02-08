pub struct Solution {}

impl Solution {
    pub fn max_subarray(nums: Vec<i32>) -> i32 {
        let mut max_current = nums[0];
        let mut max_global = nums[0];

        for i in 1..nums.len() {
            max_current = std::cmp::max(nums[i], max_current + nums[i]);
            max_global = std::cmp::max(max_global, max_current);
        }

        max_global
    }
}