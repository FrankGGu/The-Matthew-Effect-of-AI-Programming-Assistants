impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn maximum_xor(nums: Vec<i32>) -> i32 {
        let mut max_xor = 0;
        let n = nums.len();
        for i in 0..n {
            for j in i+1..n {
                let xor_val = nums[i] ^ nums[j];
                if xor_val > max_xor {
                    max_xor = xor_val;
                }
            }
        }
        max_xor
    }
}
}