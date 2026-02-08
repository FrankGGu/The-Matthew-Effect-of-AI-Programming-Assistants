struct Solution;

impl Solution {
    pub fn can_be_non_decreasing(mut nums: Vec<i32>) -> bool {
        let mut changes = 0;
        for i in 1..nums.len() {
            if nums[i] < nums[i - 1] {
                changes += 1;
                if changes > 1 {
                    return false;
                }
                if i > 1 && nums[i] < nums[i - 2] {
                    nums[i] = nums[i - 1];
                }
            }
        }
        true
    }
}