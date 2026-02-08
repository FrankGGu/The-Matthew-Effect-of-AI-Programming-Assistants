struct Solution {}

impl Solution {
    pub fn rotate(nums: &mut Vec<i32>, k: i32) {
        let k = k as usize;
        let len = nums.len();
        if len == 0 || k == 0 {
            return;
        }
        let k = k % len;
        nums.reverse();
        nums[..k].reverse();
        nums[k..].reverse();
    }
}