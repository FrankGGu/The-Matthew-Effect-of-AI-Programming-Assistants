impl Solution {

use std::cmp;

impl Solution {
    pub fn find_min_max_game(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        while nums.len() > 1 {
            let mut new_nums = Vec::new();
            for i in 0..nums.len() / 2 {
                let min_val = cmp::min(nums[2 * i], nums[2 * i + 1]);
                let max_val = cmp::max(nums[2 * i], nums[2 * i + 1]);
                new_nums.push(min_val);
                new_nums.push(max_val);
            }
            nums = new_nums;
        }
        nums[0]
    }
}
}