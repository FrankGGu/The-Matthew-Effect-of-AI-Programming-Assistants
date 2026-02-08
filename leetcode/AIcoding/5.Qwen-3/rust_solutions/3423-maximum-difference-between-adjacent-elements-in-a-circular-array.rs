impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_adjacent_diff(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n < 2 {
            return 0;
        }

        let mut min_val = nums[0];
        let mut max_val = nums[0];
        for &num in &nums {
            min_val = min_val.min(num);
            max_val = max_val.max(num);
        }

        let mut min_diff = i32::MAX;
        let mut max_diff = i32::MIN;

        for i in 1..n {
            let diff = nums[i] - nums[i - 1];
            match diff.cmp(&0) {
                Ordering::Less => min_diff = min_diff.min(diff),
                Ordering::Greater => max_diff = max_diff.max(diff),
                _ => {}
            }
        }

        let circular_diff = nums[0] + 100000 - nums[n - 1];
        min_diff = min_diff.min(circular_diff);
        max_diff = max_diff.max(circular_diff);

        if max_diff == i32::MIN {
            0
        } else {
            max_diff
        }
    }
}
}