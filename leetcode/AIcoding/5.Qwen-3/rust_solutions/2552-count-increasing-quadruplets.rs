impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_increasing_quadruplets(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut count = 0;
        let mut left_counts = vec![HashMap::new(); n];

        for i in 0..n {
            for j in 0..i {
                if nums[j] < nums[i] {
                    *left_counts[i].entry(nums[j]).or_insert(0) += 1;
                }
            }
        }

        for i in 0..n {
            for j in 0..i {
                if nums[j] < nums[i] {
                    for (&k_val, &k_count) in left_counts[j].iter() {
                        if k_val < nums[j] {
                            count += k_count;
                        }
                    }
                }
            }
        }

        count as i32
    }
}
}