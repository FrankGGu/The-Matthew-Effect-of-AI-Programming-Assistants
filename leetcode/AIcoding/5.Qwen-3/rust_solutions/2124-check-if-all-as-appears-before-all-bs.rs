struct Solution;

impl Solution {
    pub fn is_ideal_pair(nums: Vec<i32>) -> bool {
        let mut last_a = -1;
        for (i, &num) in nums.iter().enumerate() {
            if num == 0 {
                last_a = i as i32;
            } else if num == 1 {
                if last_a >= i as i32 {
                    return false;
                }
            }
        }
        true
    }
}