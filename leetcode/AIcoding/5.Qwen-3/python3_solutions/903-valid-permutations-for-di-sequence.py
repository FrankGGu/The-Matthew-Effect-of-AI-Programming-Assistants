class Solution:
    def numPermutations(self, s: str) -> int:
        MOD = 10**9 + 7
        n = len(s)
        dp = [[0] * (n + 1) for _ in range(n + 1)]
        for i in range(n + 1):
            dp[0][i] = 1
        for i in range(1, n + 1):
            for j in range(n + 1):
                if s[i - 1] == 'D':
                    for k in range(j, i):
                        dp[i][j] += dp[i - 1][k]
                        dp[i][j] %= MOD
                else:
                    for k in range(j):
                        dp[i][j] += dp[i - 1][k]
                        dp[i][j] %= MOD
        return dp[n][0]