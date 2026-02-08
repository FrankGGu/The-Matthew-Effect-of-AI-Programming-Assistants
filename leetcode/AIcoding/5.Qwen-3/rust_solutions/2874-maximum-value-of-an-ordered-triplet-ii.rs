impl Solution {

use std::cmp;

impl Solution {
    pub fn ordered_triplet_sum(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut left_min = vec![0; n];
        let mut right_max = vec![0; n];

        left_min[0] = nums[0];
        for i in 1..n {
            left_min[i] = cmp::min(left_min[i - 1], nums[i]);
        }

        right_max[n - 1] = nums[n - 1];
        for i in (0..n - 1).rev() {
            right_max[i] = cmp::max(right_max[i + 1], nums[i]);
        }

        let mut result = 0;
        for i in 1..n - 1 {
            if nums[i] > left_min[i] && nums[i] < right_max[i] {
                result += nums[i] * (i as i32) * (i as i32);
            }
        }

        result
    }
}
}