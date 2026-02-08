class Solution:
    def countPartitions(self, nums: List[int], k: int) -> int:
        MOD = 10**9 + 7
        n = len(nums)
        total = sum(nums)
        dp = [0] * (k + 1)
        dp[0] = 1
        for num in nums:
            for j in range(k - 1, -1, -1):
                dp[j] = (dp[j] + dp[j - num]) % MOD
        return (sum(dp[k:]) - 1) % MOD