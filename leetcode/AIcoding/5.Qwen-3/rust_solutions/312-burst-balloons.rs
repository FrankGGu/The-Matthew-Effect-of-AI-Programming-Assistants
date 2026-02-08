impl Solution {
    pub fn burst_balloons(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![vec![0; n]; n];

        for length in 1..=n {
            for i in 0..=n - length {
                let j = i + length - 1;
                for k in i..=j {
                    let left = if i == 0 { 0 } else { nums[i - 1] };
                    let right = if j == n - 1 { 0 } else { nums[j + 1] };
                    let curr = nums[k] * left * right;
                    let left_dp = if k > i { dp[i][k - 1] } else { 0 };
                    let right_dp = if k < j { dp[k + 1][j] } else { 0 };
                    dp[i][j] = std::cmp::max(dp[i][j], left_dp + right_dp + curr);
                }
            }
        }

        dp[0][n - 1]
    }
}