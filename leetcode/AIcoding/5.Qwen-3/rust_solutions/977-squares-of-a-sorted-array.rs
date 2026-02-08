struct Solution;

impl Solution {
    pub fn sorted_squares(nums: Vec<i32>) -> Vec<i32> {
        let mut result = vec![0; nums.len()];
        let mut left = 0;
        let mut right = nums.len() - 1;
        let mut index = right;

        while left <= right {
            let left_sq = nums[left].pow(2);
            let right_sq = nums[right].pow(2);

            if left_sq > right_sq {
                result[index] = left_sq;
                left += 1;
            } else {
                result[index] = right_sq;
                right -= 1;
            }

            index -= 1;
        }

        result
    }
}