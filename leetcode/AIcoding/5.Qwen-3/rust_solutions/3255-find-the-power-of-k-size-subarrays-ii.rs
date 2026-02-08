struct Solution;

impl Solution {
    pub fn results_array(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let k = k as usize;
        let n = nums.len();
        let mut result = Vec::with_capacity(n - k + 1);
        let mut current = 0;

        for i in 0..n {
            if i > 0 && nums[i] == nums[i - 1] + 1 {
                current += 1;
            } else {
                current = 1;
            }

            if i >= k - 1 {
                result.push(current);
            }
        }

        result
    }
}