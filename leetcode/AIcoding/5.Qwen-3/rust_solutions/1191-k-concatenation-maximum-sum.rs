impl Solution {
    pub fn max_subarray_sum(mut nums: Vec<i32>) -> i32 {
        let mut max_ending_here = nums[0];
        let mut max_so_far = nums[0];

        for &num in &nums[1..] {
            max_ending_here = std::cmp::max(num, max_ending_here + num);
            max_so_far = std::cmp::max(max_so_far, max_ending_here);
        }

        max_so_far
    }

    pub fn k_concatenation_max_sum(nums: Vec<i32>, k: i32) -> i32 {
        if k == 1 {
            return Solution::max_subarray_sum(nums);
        }

        let total_sum = nums.iter().sum::<i32>();
        let max_prefix = {
            let mut current = 0;
            let mut max_val = 0;
            for &num in &nums {
                current += num;
                max_val = std::cmp::max(max_val, current);
            }
            max_val
        };

        let max_suffix = {
            let mut current = 0;
            let mut max_val = 0;
            for &num in nums.iter().rev() {
                current += num;
                max_val = std::cmp::max(max_val, current);
            }
            max_val
        };

        let max_single = Solution::max_subarray_sum(nums.clone());
        let max_double = max_prefix + max_suffix;

        if k == 2 {
            return std::cmp::max(max_single, max_double);
        } else {
            return std::cmp::max(max_single, max_double + (k - 2) * total_sum);
        }
    }
}