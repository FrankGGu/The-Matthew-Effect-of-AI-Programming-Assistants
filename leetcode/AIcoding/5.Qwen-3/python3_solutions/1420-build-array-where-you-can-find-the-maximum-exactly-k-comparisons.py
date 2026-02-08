class Solution:
    def numOfArrays(self, n: int, k: int) -> int:
        MOD = 10**9 + 7
        dp = [[0] * (k + 1) for _ in range(n + 1)]
        for i in range(1, n + 1):
            dp[i][1] = 1
        for j in range(2, k + 1):
            for i in range(j, n + 1):
                for m in range(j - 1, i):
                    dp[i][j] += dp[m][j - 1] * (i - m)
                    dp[i][j] %= MOD
        return sum(dp[n][k]) % MOD