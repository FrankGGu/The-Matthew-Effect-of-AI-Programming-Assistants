class Solution:
    def minExtraChar(self, s: str, targetWords: list[str]) -> int:
        from collections import deque

        n = len(s)
        wordSet = set(targetWords)
        dp = [float('inf')] * (n + 1)
        dp[0] = 0

        for i in range(n):
            if s[i] in wordSet:
                dp[i + 1] = min(dp[i + 1], dp[i])
            for j in range(i + 1):
                if s[j:i + 1] in wordSet:
                    dp[i + 1] = min(dp[i + 1], dp[j])

        return n - dp[n]