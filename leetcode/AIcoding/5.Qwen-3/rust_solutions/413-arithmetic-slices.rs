pub struct Solution {}

impl Solution {
    pub fn number_of_arithmetic_slices(nums: Vec<i32>) -> i32 {
        if nums.len() < 2 {
            return 0;
        }

        let mut count = 0;
        let mut diff = nums[1] - nums[0];
        let mut current_length = 2;

        for i in 2..nums.len() {
            if nums[i] - nums[i - 1] == diff {
                current_length += 1;
            } else {
                if current_length >= 2 {
                    count += (current_length - 1) * (current_length - 2) / 2;
                }
                diff = nums[i] - nums[i - 1];
                current_length = 2;
            }
        }

        if current_length >= 2 {
            count += (current_length - 1) * (current_length - 2) / 2;
        }

        count
    }
}