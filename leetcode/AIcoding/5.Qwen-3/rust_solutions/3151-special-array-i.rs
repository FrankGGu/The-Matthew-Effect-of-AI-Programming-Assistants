struct Solution;

impl Solution {
    pub fn special_array(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len() as i32;
        for i in 0..n {
            let count = n - i;
            if nums[i] >= count && (i == 0 || nums[i - 1] < count) {
                return count;
            }
        }
        -1
    }
}