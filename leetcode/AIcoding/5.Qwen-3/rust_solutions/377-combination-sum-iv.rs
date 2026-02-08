impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn combination_sum_4(mut nums: Vec<i32>, target: i32) -> i32 {
        let mut memo = HashMap::new();
        Self::dfs(&nums, target, &mut memo)
    }

    fn dfs(nums: &[i32], target: i32, memo: &mut HashMap<i32, i32>) -> i32 {
        if target == 0 {
            return 1;
        }
        if let Some(&count) = memo.get(&target) {
            return count;
        }

        let mut total = 0;
        for &num in nums {
            if num <= target {
                total += Self::dfs(nums, target - num, memo);
            }
        }

        memo.insert(target, total);
        total
    }
}
}