class Solution:
    def minPathCost(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        dp = [[0] * n for _ in range(m)]
        dp[0] = grid[0][:]
        for i in range(1, m):
            for j in range(n):
                min_prev = min(dp[i-1][k] + abs(j - k) for k in range(n))
                dp[i][j] = min_prev + grid[i][j]
        return min(dp[-1])