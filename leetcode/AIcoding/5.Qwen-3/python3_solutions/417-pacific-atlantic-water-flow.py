class Solution:
    def pacificAtlantic(self, matrix):
        if not matrix or not matrix[0]:
            return []

        rows, cols = len(matrix), len(matrix[0])
        pacific_visited = [[False for _ in range(cols)] for _ in range(rows)]
        atlantic_visited = [[False for _ in range(cols)] for _ in range(rows)]

        def dfs(r, c, visited):
            visited[r][c] = True
            for dr, dc in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                nr, nc = r + dr, c + dc
                if 0 <= nr < rows and 0 <= nc < cols and not visited[nr][nc] and matrix[nr][nc] >= matrix[r][c]:
                    dfs(nr, nc, visited)

        for r in range(rows):
            dfs(r, 0, pacific_visited)
            dfs(r, cols - 1, atlantic_visited)

        for c in range(cols):
            dfs(0, c, pacific_visited)
            dfs(rows - 1, c, atlantic_visited)

        result = []
        for r in range(rows):
            for c in range(cols):
                if pacific_visited[r][c] and atlantic_visited[r][c]:
                    result.append([r, c])

        return result