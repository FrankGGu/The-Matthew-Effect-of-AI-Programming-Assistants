class Solution:
    def minOperations(self, nums: List[int]) -> int:
        from collections import defaultdict

        n = len(nums)
        dp = [defaultdict(int) for _ in range(n + 1)]
        dp[0][0] = 0

        for i in range(n):
            for key in dp[i]:
                val = dp[i][key]
                dp[i + 1][key] = min(dp[i + 1][key], val)
                dp[i + 1][key ^ nums[i]] = min(dp[i + 1][key ^ nums[i]], val + 1)

        return dp[n][0]