struct Solution;

impl Solution {
    pub fn jump(nums: Vec<i32>) -> i32 {
        let mut jumps = 0;
        let mut current_end = 0;
        let mut farthest = 0;

        for i in 0..nums.len() - 1 {
            farthest = std::cmp::max(farthest, i + nums[i] as usize);

            if i == current_end {
                jumps += 1;
                current_end = farthest;
            }
        }

        jumps
    }
}