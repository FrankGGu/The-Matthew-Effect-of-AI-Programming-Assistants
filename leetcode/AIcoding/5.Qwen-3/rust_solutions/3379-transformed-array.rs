struct Solution;

impl Solution {
    pub fn transform_array(nums: Vec<i32>) -> Vec<i32> {
        let mut result = nums.clone();
        let n = nums.len();

        for i in 1..n - 1 {
            let left = nums[i - 1];
            let right = nums[i + 1];
            if left < right {
                result[i] = left;
            } else if left > right {
                result[i] = right;
            }
        }

        result
    }
}