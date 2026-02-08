class Solution:
    def knightProbability(self, n: int, k: int, row: int, column: int) -> float:
        from collections import deque

        directions = [(-2, -1), (-2, 1), (-1, -2), (-1, 2), (1, -2), (1, 2), (2, -1), (2, 1)]
        dp = [[0.0] * n for _ in range(n)]
        dp[row][column] = 1.0

        for step in range(k):
            next_dp = [[0.0] * n for _ in range(n)]
            for i in range(n):
                for j in range(n):
                    if dp[i][j] > 0:
                        for dx, dy in directions:
                            ni, nj = i + dx, j + dy
                            if 0 <= ni < n and 0 <= nj < n:
                                next_dp[ni][nj] += dp[i][j] / 8.0
            dp = next_dp

        total = sum(sum(row) for row in dp)
        return total