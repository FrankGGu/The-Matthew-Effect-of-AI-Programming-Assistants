class Solution:
    def countPyramids(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        dp = [[0] * n for _ in range(m)]

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 1:
                    if i == 0 or j == 0 or j == n - 1:
                        dp[i][j] = 1
                    else:
                        dp[i][j] = min(dp[i-1][j-1], dp[i-1][j], dp[i-1][j+1]) + 1

        res = 0
        for i in range(m):
            for j in range(n):
                res += max(0, dp[i][j] - 1)

        return res