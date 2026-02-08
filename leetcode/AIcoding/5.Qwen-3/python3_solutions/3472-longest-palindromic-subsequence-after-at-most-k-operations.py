class Solution:
    def longestDecompression(self, text: str, k: int) -> int:
        n = len(text)
        dp = [[0] * (n + 1) for _ in range(n + 1)]

        for i in range(n):
            for j in range(n):
                if text[i] == text[j]:
                    dp[i][j] = dp[i - 1][j - 1] + 1
                else:
                    dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])

        return dp[n - 1][n - 1]