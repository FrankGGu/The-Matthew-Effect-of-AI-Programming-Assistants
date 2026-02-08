class Solution:
    def checkRecord(self, n: int) -> int:
        MOD = 10**9 + 7
        dp = [[0] * 3 for _ in range(2)]
        dp[0][0] = 1
        for i in range(1, n + 1):
            for j in range(2):
                for k in range(3):
                    dp[j][k] = dp[j][k] % MOD
                    if j == 0:
                        dp[j][k] = (dp[j][k] + dp[1][k]) % MOD
                    if k == 0:
                        dp[j][k] = (dp[j][k] + dp[j][0]) % MOD
                    if k == 1:
                        dp[j][k] = (dp[j][k] + dp[j][1]) % MOD
                    if k == 2:
                        dp[j][k] = (dp[j][k] + dp[j][2]) % MOD
        return (dp[0][0] + dp[0][1] + dp[0][2]) % MOD