struct Solution;

impl Solution {
    pub fn xor_sum(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let mut result = 0;
        for &num1 in &nums1 {
            for &num2 in &nums2 {
                result ^= (num1 & num2);
            }
        }
        result
    }
}