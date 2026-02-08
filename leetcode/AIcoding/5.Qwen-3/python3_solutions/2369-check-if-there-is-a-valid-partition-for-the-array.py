class Solution:
    def validPartition(self, nums: List[int]) -> bool:
        n = len(nums)
        dp = [False] * (n + 1)
        dp[0] = True
        for i in range(3, n + 1):
            if dp[i - 3] and (nums[i - 3] == nums[i - 2] == nums[i - 1] or (nums[i - 3] == nums[i - 2] - 1 and nums[i - 2] == nums[i - 1] - 1)):
                dp[i] = True
            elif dp[i - 2] and nums[i - 2] == nums[i - 1]:
                dp[i] = True
        return dp[n]