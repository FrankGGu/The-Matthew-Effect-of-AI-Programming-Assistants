impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn divide_array(nums: Vec<i32>, k: i32) -> Vec<Vec<i32>> {
        let mut nums = nums;
        nums.sort();
        let mut result = Vec::new();
        let mut group = Vec::new();

        for &num in &nums {
            if group.len() == 0 {
                group.push(num);
            } else if num - group[0] <= k {
                group.push(num);
            } else {
                result.push(group);
                group = vec![num];
            }
        }

        if !group.is_empty() {
            result.push(group);
        }

        result
    }
}
}