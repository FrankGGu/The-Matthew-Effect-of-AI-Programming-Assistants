class Solution:
    def minOperations(self, nums: str) -> int:
        n = len(nums)
        dp = [0] * 3
        for i in range(n):
            new_dp = [float('inf')] * 3
            if nums[i] == '0':
                new_dp[0] = dp[0]
                new_dp[1] = dp[1] + 1
                new_dp[2] = dp[2] + 1
            else:
                new_dp[0] = dp[0] + 1
                new_dp[1] = dp[1]
                new_dp[2] = dp[2] + 1
            dp = new_dp
        return min(dp)