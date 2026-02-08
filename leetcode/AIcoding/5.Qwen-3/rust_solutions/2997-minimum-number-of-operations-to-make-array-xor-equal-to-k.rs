struct Solution;

impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut xor = 0;
        for num in nums {
            xor ^= num;
        }
        let diff = xor ^ k;
        let mut count = 0;
        while diff > 0 {
            count += diff & 1;
            diff >>= 1;
        }
        count
    }
}