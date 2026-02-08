class Solution:
    def countTheNumOfWinningSequences(self, n: int) -> int:
        from collections import defaultdict

        dp = [defaultdict(int) for _ in range(n + 1)]
        dp[0][0] = 1

        for i in range(1, n + 1):
            for j in range(i + 1):
                for k in range(j + 1):
                    if j - k >= 0:
                        dp[i][j] += dp[i - 1][j - k]

        return sum(dp[n].values())