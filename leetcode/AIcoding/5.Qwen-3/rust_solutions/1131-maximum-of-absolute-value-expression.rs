struct Solution;

impl Solution {
    pub fn max_abs_val_expr(nums: Vec<i32>, x: i32, y: i32) -> i32 {
        let mut max_val = i32::MIN;
        let mut min_val = i32::MAX;

        for i in 0..nums.len() {
            let val = (nums[i] as i32 - x) * (i as i32) + (nums[i] as i32 - y);
            max_val = std::cmp::max(max_val, val);
            min_val = std::cmp::min(min_val, val);
        }

        max_val - min_val
    }
}