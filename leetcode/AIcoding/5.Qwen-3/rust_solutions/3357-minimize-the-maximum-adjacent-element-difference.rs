struct Solution;

impl Solution {
    pub fn minimize_max_diff(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut dp = vec![vec![0; k as usize + 1]; n];

        for i in 0..n {
            for j in 0..=k as usize {
                if j == 0 {
                    dp[i][j] = 0;
                } else {
                    dp[i][j] = std::i32::MAX;
                    for m in 0..i {
                        dp[i][j] = dp[i][j].min(dp[m][j - 1].max(nums[i] - nums[m]));
                    }
                }
            }
        }

        dp[n - 1][k as usize]
    }
}