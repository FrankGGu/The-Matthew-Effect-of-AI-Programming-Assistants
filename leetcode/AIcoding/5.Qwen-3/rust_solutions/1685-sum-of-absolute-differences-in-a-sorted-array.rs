struct Solution;

impl Solution {
    pub fn absolute_sums(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut prefix = vec![0; n];
        for i in 1..n {
            prefix[i] = prefix[i - 1] + nums[i - 1];
        }
        let mut result = vec![0; n];
        for i in 0..n {
            let left = nums[i] * (i as i32) - prefix[i];
            let right = (prefix[n] - prefix[i]) - nums[i] * ((n - i) as i32);
            result[i] = left + right;
        }
        result
    }
}