struct Solution;

impl Solution {
    pub fn closest_to_zero(nums: Vec<i32>) -> i32 {
        let mut closest = nums[0];
        for &num in &nums {
            if num.abs() < closest.abs() || (num.abs() == closest.abs() && num > closest) {
                closest = num;
            }
        }
        closest
    }
}