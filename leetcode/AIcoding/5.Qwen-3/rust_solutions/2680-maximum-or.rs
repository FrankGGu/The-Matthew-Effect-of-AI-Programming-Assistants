struct Solution;

impl Solution {
    pub fn maximum_or(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut left = vec![0; n];
        let mut right = vec![0; n];

        for i in 1..n {
            left[i] = left[i - 1] | nums[i - 1];
        }

        for i in (0..n - 1).rev() {
            right[i] = right[i + 1] | nums[i + 1];
        }

        let mut max_or = 0;
        for i in 0..n {
            let current = (left[i] | nums[i] << k) | right[i];
            max_or = max_or.max(current);
        }

        max_or
    }
}