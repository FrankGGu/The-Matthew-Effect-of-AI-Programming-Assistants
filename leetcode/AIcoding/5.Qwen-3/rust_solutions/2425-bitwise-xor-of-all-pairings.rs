impl Solution {
    pub fn xor_all_pairings(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let mut result = 0;
        for &num in &nums1 {
            for &other in &nums2 {
                result ^= num ^ other;
            }
        }
        result
    }
}