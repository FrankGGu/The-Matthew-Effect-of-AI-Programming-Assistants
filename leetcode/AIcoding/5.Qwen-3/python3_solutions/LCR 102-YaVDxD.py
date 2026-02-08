class Solution:
    def findTargetSumWays(self, nums: List[int], target: int) -> int:
        from collections import defaultdict

        dp = defaultdict(int)
        dp[0] = 1

        for num in nums:
            next_dp = defaultdict(int)
            for key in dp:
                next_dp[key + num] += dp[key]
                next_dp[key - num] += dp[key]
            dp = next_dp

        return dp[target]