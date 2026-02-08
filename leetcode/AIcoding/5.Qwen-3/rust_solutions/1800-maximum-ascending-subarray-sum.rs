pub struct Solution {}

impl Solution {
    pub fn max_ascending_sum(nums: Vec<i32>) -> i32 {
        let mut max_sum = 0;
        let mut current_sum = 0;

        for i in 0..nums.len() {
            if i == 0 || nums[i] > nums[i - 1] {
                current_sum += nums[i];
            } else {
                current_sum = nums[i];
            }
            max_sum = std::cmp::max(max_sum, current_sum);
        }

        max_sum
    }
}