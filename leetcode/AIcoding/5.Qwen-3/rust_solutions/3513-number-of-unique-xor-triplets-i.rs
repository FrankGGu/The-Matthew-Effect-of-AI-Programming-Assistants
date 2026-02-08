impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn unique_triplet_xor(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut seen = HashSet::new();
        let mut result = 0;

        for i in 0..n {
            for j in i + 1..n {
                for k in j + 1..n {
                    let xor_val = nums[i] ^ nums[j] ^ nums[k];
                    if !seen.contains(&xor_val) {
                        seen.insert(xor_val);
                        result += 1;
                    }
                }
            }
        }

        result
    }
}
}