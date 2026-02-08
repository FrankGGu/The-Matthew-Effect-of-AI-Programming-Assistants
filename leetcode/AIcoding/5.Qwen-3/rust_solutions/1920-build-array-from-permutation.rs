impl Solution {

use std::vec;

impl Solution {
    pub fn build_array(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![0; n];
        for i in 0..n {
            result[i] = nums[nums[i] as usize];
        }
        result
    }
}
}