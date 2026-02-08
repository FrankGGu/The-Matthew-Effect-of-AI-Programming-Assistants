impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn maximum_score(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut left = 0;
        let mut right = n - 1;
        let mut score = 0;
        let mut unique = HashSet::new();

        while left <= right {
            if unique.contains(&nums[left]) {
                left += 1;
            } else if unique.contains(&nums[right]) {
                right -= 1;
            } else {
                unique.insert(nums[left]);
                unique.insert(nums[right]);
                score += nums[left] + nums[right];
                left += 1;
                right -= 1;
            }
        }

        score
    }
}
}