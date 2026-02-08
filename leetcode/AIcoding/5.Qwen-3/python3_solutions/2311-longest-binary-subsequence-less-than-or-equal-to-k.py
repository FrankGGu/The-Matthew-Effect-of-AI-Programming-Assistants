class Solution:
    def longestBinarySubsequence(self, binary: str, k: int) -> int:
        n = len(binary)
        dp = [0] * (n + 1)
        for i in range(1, n + 1):
            dp[i] = dp[i - 1]
            if binary[i - 1] == '1':
                j = i - 1
                val = 0
                while j >= 0 and val <= k:
                    val = val * 2 + 1
                    if val <= k:
                        dp[i] = max(dp[i], dp[j] + 1)
                    j -= 1
        return dp[n]