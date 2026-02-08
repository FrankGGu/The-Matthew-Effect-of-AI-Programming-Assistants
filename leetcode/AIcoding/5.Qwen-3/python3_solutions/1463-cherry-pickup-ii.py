class Solution:
    def cherryPickup(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        dp = [[[ -1 for _ in range(n)] for _ in range(n)] for _ in range(m)]

        def dfs(row, col1, col2):
            if row == m:
                return 0
            if dp[row][col1][col2] != -1:
                return dp[row][col1][col2]

            res = 0
            for d1 in [-1, 0, 1]:
                for d2 in [-1, 0, 1]:
                    new_col1 = col1 + d1
                    new_col2 = col2 + d2
                    if 0 <= new_col1 < n and 0 <= new_col2 < n:
                        res = max(res, dfs(row + 1, new_col1, new_col2))
            current_cherries = grid[row][col1] + (grid[row][col2] if col1 != col2 else 0)
            dp[row][col1][col2] = current_cherries + res
            return dp[row][col1][col2]

        return dfs(0, 0, n - 1)