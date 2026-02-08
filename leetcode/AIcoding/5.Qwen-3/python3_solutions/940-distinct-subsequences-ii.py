class Solution:
    def distinctSubseqA(self, s: str) -> int:
        MOD = 10**9 + 7
        dp = [1] * (len(s) + 1)
        last = {}
        for i in range(1, len(s) + 1):
            dp[i] = (dp[i - 1] * 2) % MOD
            if s[i - 1] in last:
                dp[i] = (dp[i] - dp[last[s[i - 1]] - 1]) % MOD
            last[s[i - 1]] = i
        return dp[len(s)] - 1