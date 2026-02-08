class Solution:
    def longestIncreasingPath(self, matrix: List[List[int]]) -> int:
        if not matrix or not matrix[0]:
            return 0
        rows, cols = len(matrix), len(matrix[0])
        memo = [[0] * cols for _ in range(rows)]
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        def dfs(r, c):
            if memo[r][c] != 0:
                return memo[r][c]
            max_len = 1
            for dr, dc in directions:
                nr, nc = r + dr, c + dc
                if 0 <= nr < rows and 0 <= nc < cols and matrix[nr][nc] > matrix[r][c]:
                    current_len = 1 + dfs(nr, nc)
                    max_len = max(max_len, current_len)
            memo[r][c] = max_len
            return max_len

        result = 0
        for i in range(rows):
            for j in range(cols):
                result = max(result, dfs(i, j))
        return result