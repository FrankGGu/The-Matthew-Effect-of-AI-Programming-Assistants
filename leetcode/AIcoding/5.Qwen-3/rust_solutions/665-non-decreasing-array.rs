struct Solution;

impl Solution {
    pub fn check_after_increasing(nums: Vec<i32>) -> bool {
        let mut count = 0;
        for i in 1..nums.len() {
            if nums[i] < nums[i - 1] {
                count += 1;
                if count > 1 {
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