impl Solution {

use std::cmp;

impl Solution {
    pub fn max_subarray_sum_circular(nums: Vec<i32>) -> i32 {
        let mut total = 0;
        let mut max_subarray_sum = nums[0];
        let mut current_max = nums[0];
        let mut min_subarray_sum = nums[0];
        let mut current_min = nums[0];

        for &num in &nums[1..] {
            current_max = cmp::max(num, current_max + num);
            max_subarray_sum = cmp::max(max_subarray_sum, current_max);

            current_min = cmp::min(num, current_min + num);
            min_subarray_sum = cmp::min(min_subarray_sum, current_min);

            total += num;
        }

        if max_subarray_sum < 0 {
            return max_subarray_sum;
        }

        cmp::max(max_subarray_sum, total - min_subarray_sum)
    }
}
}