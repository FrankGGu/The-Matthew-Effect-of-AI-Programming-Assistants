impl Solution {
    pub fn minimum_sum(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut left = vec![0; n];
        let mut right = vec![0; n];

        for i in 1..n {
            left[i] = if nums[i] > nums[i - 1] { left[i - 1] + nums[i - 1] } else { nums[i - 1] };
        }

        for i in (0..n - 1).rev() {
            right[i] = if nums[i] > nums[i + 1] { right[i + 1] + nums[i + 1] } else { nums[i + 1] };
        }

        let mut min_sum = i32::MAX;
        for i in 1..n - 1 {
            if nums[i - 1] < nums[i] && nums[i] > nums[i + 1] {
                let sum = left[i] + nums[i] + right[i];
                min_sum = std::cmp::min(min_sum, sum);
            }
        }

        if min_sum == i32::MAX {
            -1
        } else {
            min_sum
        }
    }
}