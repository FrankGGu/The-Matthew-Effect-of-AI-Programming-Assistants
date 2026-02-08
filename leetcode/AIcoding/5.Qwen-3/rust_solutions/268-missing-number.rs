struct Solution;

impl Solution {
    pub fn missing_number(nums: Vec<i32>) -> i32 {
        let n = nums.len() as i32;
        let mut xor = 0;
        for i in 0..n {
            xor ^= nums[i];
            xor ^= i;
        }
        xor ^= n;
        xor
    }
}