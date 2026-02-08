impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn find_k_distant_indices(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let n = nums.len();
        let mut result = HashSet::new();
        for (i, &num) in nums.iter().enumerate() {
            for j in 0..n {
                if (i as i32 - j as i32).abs() <= k {
                    result.insert(j as i32);
                }
            }
        }
        let mut result: Vec<i32> = result.into_iter().collect();
        result.sort();
        result
    }
}
}