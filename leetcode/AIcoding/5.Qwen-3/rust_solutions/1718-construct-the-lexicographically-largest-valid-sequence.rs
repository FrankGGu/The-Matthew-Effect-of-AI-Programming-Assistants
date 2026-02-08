impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn construct_valid_sequence(nums: Vec<i32>) -> Vec<i32> {
        let mut result = vec![];
        let mut used = HashSet::new();
        let n = nums.len();

        fn backtrack(
            nums: &Vec<i32>,
            used: &mut HashSet<usize>,
            path: &mut Vec<i32>,
            result: &mut Vec<i32>,
            n: usize,
        ) -> bool {
            if path.len() == n {
                *result = path.clone();
                return true;
            }

            for i in 0..n {
                if used.contains(&i) {
                    continue;
                }

                if !path.is_empty() && (path.last().unwrap() + nums[i] != 1) {
                    continue;
                }

                used.insert(i);
                path.push(nums[i]);

                if backtrack(nums, used, path, result, n) {
                    return true;
                }

                path.pop();
                used.remove(&i);
            }

            false
        }

        backtrack(&nums, &mut used, &mut vec![], &mut result, n);
        result
    }
}
}