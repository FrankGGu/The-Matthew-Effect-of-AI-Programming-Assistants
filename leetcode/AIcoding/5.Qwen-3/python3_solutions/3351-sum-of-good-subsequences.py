class Solution:
    def sumOfGoodSubsequences(self, s: str) -> int:
        from collections import defaultdict

        MOD = 10**9 + 7
        dp = [defaultdict(int) for _ in range(len(s))]
        total = 0

        for i in range(len(s)):
            for j in range(i):
                if s[j] == s[i]:
                    for key in dp[j]:
                        dp[i][key] = (dp[i][key] + dp[j][key]) % MOD
            dp[i][s[i]] = (dp[i][s[i]] + 1) % MOD
            for key in dp[i]:
                total = (total + dp[i][key]) % MOD

        return total