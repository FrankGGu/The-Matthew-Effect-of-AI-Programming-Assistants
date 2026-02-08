impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn subsets_with_dup(mut nums: Vec<i32>) -> Vec<Vec<i32>> {
        nums.sort();
        let mut result = vec![];
        let mut path = vec![];
        Self::backtrack(&nums, 0, &mut path, &mut result);
        result
    }

    fn backtrack(nums: &[i32], start: usize, path: &mut Vec<i32>, result: &mut Vec<Vec<i32>>) {
        result.push(path.clone());
        for i in start..nums.len() {
            if i > start && nums[i] == nums[i - 1] {
                continue;
            }
            path.push(nums[i]);
            Self::backtrack(nums, i + 1, path, result);
            path.pop();
        }
    }
}
}