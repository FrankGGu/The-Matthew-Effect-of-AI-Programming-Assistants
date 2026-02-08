class Solution:
    def maxIncreasingCells(self, matrix: List[List[int]]) -> int:
        from collections import defaultdict, deque

        m, n = len(matrix), len(matrix[0])
        cell_val = []
        for i in range(m):
            for j in range(n):
                cell_val.append((matrix[i][j], i, j))

        cell_val.sort()

        dp = [[0] * n for _ in range(m)]
        row_map = defaultdict(list)
        col_map = defaultdict(list)

        for val, i, j in cell_val:
            row_map[i].append((val, i, j))
            col_map[j].append((val, i, j))

        for val, i, j in cell_val:
            max_prev = 0
            for v, x, y in row_map[i]:
                if v < val:
                    max_prev = max(max_prev, dp[x][y])
            for v, x, y in col_map[j]:
                if v < val:
                    max_prev = max(max_prev, dp[x][y])
            dp[i][j] = max_prev + 1

        return max(max(row) for row in dp)