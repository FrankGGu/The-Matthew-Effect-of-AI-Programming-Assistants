impl Solution {

use std::cmp;

impl Solution {
    pub fn ship_capacity(weights: Vec<i32>, days: i32) -> i32 {
        let (mut left, mut right) = (0, 0);
        for &w in &weights {
            left = cmp::max(left, w);
            right += w;
        }

        while left < right {
            let mid = left + (right - left) / 2;
            let mut current_sum = 0;
            let mut current_days = 1;

            for &w in &weights {
                if current_sum + w > mid {
                    current_days += 1;
                    current_sum = w;
                } else {
                    current_sum += w;
                }
            }

            if current_days <= days {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        left
    }
}
}