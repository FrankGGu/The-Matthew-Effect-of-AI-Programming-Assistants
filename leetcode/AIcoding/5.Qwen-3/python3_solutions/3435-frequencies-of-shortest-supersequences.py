class Solution:
    def numShortestSupersequences(self, s1: str, s2: str) -> int:
        from collections import defaultdict

        m, n = len(s1), len(s2)
        dp = [[0] * (n + 1) for _ in range(m + 1)]
        count = [[0] * (n + 1) for _ in range(m + 1)]

        for i in range(m + 1):
            dp[i][n] = n
            count[i][n] = 1

        for j in range(n + 1):
            dp[m][j] = m
            count[m][j] = 1

        for i in range(m - 1, -1, -1):
            for j in range(n - 1, -1, -1):
                if s1[i] == s2[j]:
                    dp[i][j] = 1 + dp[i + 1][j + 1]
                    count[i][j] = count[i + 1][j + 1]
                else:
                    if dp[i + 1][j] < dp[i][j + 1]:
                        dp[i][j] = 1 + dp[i + 1][j]
                        count[i][j] = count[i + 1][j]
                    elif dp[i + 1][j] > dp[i][j + 1]:
                        dp[i][j] = 1 + dp[i][j + 1]
                        count[i][j] = count[i][j + 1]
                    else:
                        dp[i][j] = 1 + dp[i + 1][j]
                        count[i][j] = count[i + 1][j] + count[i][j + 1]

        return count[0][0]