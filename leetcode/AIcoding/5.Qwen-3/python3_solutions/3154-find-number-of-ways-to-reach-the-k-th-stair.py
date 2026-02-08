class Solution:
    def waysToReachKthStair(self, k: int) -> int:
        if k == 0:
            return 1
        dp = [0] * (k + 1)
        dp[0] = 1
        for i in range(1, k + 1):
            dp[i] = dp[i - 1]
            if i >= 2:
                dp[i] += dp[i - 2]
        return dp[k]