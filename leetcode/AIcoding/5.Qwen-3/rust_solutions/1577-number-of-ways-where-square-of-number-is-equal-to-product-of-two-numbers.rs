impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_triplets(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let n = nums.len();

        for i in 0..n {
            for j in (i + 1)..n {
                let product = nums[i] * nums[j];
                for k in 0..n {
                    if k != i && k != j && nums[k] * nums[k] == product {
                        count += 1;
                    }
                }
            }
        }

        count
    }
}
}