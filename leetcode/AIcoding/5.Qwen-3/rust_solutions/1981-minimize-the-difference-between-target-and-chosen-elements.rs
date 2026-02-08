impl Solution {

use std::collections::BTreeSet;

impl Solution {
    pub fn minimize_mean_diff(nums: Vec<i32>, target: i32) -> i32 {
        let mut candidates = BTreeSet::new();
        for &num in &nums {
            candidates.insert(num);
        }

        let mut min_diff = i32::MAX;
        let mut stack = vec![(0, 0)];

        while let Some((idx, curr_sum)) = stack.pop() {
            if idx == nums.len() {
                let diff = (curr_sum - target).abs();
                min_diff = std::cmp::min(min_diff, diff);
                continue;
            }

            for &candidate in &candidates {
                stack.push((idx + 1, curr_sum + candidate));
            }
        }

        min_diff
    }
}
}