impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn maximum_element_sum(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut visited = HashSet::new();
        let mut max_sum = 0;

        for i in 0..n {
            if !visited.contains(&i) {
                let mut current_sum = 0;
                let mut j = i;
                while !visited.contains(&j) {
                    visited.insert(j);
                    current_sum += nums[j] as i64;
                    j = (j + 1) % n;
                }
                max_sum = std::cmp::max(max_sum, current_sum);
            }
        }

        max_sum
    }
}
}