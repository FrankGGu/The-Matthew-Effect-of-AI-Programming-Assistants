class Solution:
    def buyProducts(self, n: int, k: int) -> int:
        dp = [0] * (k + 1)
        dp[0] = 1
        for i in range(1, n + 1):
            for j in range(k, -1, -1):
                if j >= i:
                    dp[j] += dp[j - i]
        return dp[k]