class Solution:
    def profitableSchemes(self, n: int, k: int, dp: List[List[int]]) -> int:
        MOD = 10**9 + 7
        dp = [[0] * (n + 1) for _ in range(k + 1)]
        for i in range(k + 1):
            dp[i][0] = 1
        for i in range(1, k + 1):
            for j in range(1, n + 1):
                dp[i][j] = dp[i - 1][j]
                if j >= i:
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - i]) % MOD
        return dp[k][n]