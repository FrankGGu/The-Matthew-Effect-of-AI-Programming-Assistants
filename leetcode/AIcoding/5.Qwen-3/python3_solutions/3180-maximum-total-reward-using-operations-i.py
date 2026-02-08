class Solution:
    def maxTotalReward(self, nums: List[int]) -> int:
        nums = sorted(set(nums))
        n = len(nums)
        dp = [0] * (n + 1)
        for i in range(n):
            dp[i + 1] = dp[i]
            if nums[i] > dp[i]:
                dp[i + 1] = max(dp[i + 1], dp[i] + nums[i])
        return dp[-1]