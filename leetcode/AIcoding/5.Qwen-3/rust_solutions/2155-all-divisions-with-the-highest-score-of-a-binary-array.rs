impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn max_score_indices(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut left_zero = 0;
        let mut left_one = 0;
        let mut right_zero = 0;
        let mut right_one = 0;

        for i in 0..n {
            if nums[i] == 0 {
                right_zero += 1;
            } else {
                right_one += 1;
            }
        }

        let mut max_score = 0;
        let mut result = Vec::new();

        for i in 0..=n {
            let score = left_zero + left_one + (right_zero - (if i > 0 { nums[i - 1] == 0 } else { false }) as i32) + (right_one - (if i > 0 { nums[i - 1] == 1 } else { false }) as i32);

            if score > max_score {
                max_score = score;
                result.clear();
                result.push(i as i32);
            } else if score == max_score {
                result.push(i as i32);
            }

            if i < n {
                if nums[i] == 0 {
                    left_zero += 1;
                    right_zero -= 1;
                } else {
                    left_one += 1;
                    right_one -= 1;
                }
            }
        }

        result
    }
}
}