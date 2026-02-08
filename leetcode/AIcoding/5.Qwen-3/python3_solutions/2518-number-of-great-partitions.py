class Solution:
    def countOfGreatPartitions(self, nums: List[int], k: int) -> int:
        MOD = 10**9 + 7
        n = len(nums)
        dp = [0] * (k + 1)
        dp[0] = 1
        for num in nums:
            for i in range(k - 1, -1, -1):
                dp[i] = (dp[i] + dp[(i - num) % k]) % MOD
        return (dp[0] - 1) % MOD