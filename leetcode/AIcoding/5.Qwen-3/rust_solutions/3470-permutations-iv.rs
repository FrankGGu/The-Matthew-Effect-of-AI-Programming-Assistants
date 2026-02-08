impl Solution {

use std::vec::Vec;

impl Solution {
    pub fn permute(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut path = Vec::new();
        let mut used = vec![false; nums.len()];
        Self::backtrack(&nums, &mut path, &mut used, &mut result);
        result
    }

    fn backtrack(nums: &Vec<i32>, path: &mut Vec<i32>, used: &mut Vec<bool>, result: &mut Vec<Vec<i32>>) {
        if path.len() == nums.len() {
            result.push(path.clone());
            return;
        }

        for i in 0..nums.len() {
            if !used[i] {
                used[i] = true;
                path.push(nums[i]);
                Self::backtrack(nums, path, used, result);
                path.pop();
                used[i] = false;
            }
        }
    }
}

pub struct Solution;
}