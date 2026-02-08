class Solution:
    def maxDifference(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        max_row = [max(row) for row in grid]
        min_row = [min(row) for row in grid]
        max_col = [max(grid[i][j] for i in range(m)) for j in range(n)]
        min_col = [min(grid[i][j] for i in range(m)) for j in range(n)]
        max_diff = 0
        for i in range(m):
            for j in range(n):
                current = grid[i][j]
                row_max = max_row[i]
                row_min = min_row[i]
                col_max = max_col[j]
                col_min = min_col[j]
                diff = max(row_max - current, current - row_min, col_max - current, current - col_min)
                max_diff = max(max_diff, diff)
        return max_diff