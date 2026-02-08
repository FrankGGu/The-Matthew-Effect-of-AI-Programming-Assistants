class Solution:
    def isKnightTour(self, grid):
        n = len(grid)
        directions = [(2, 1), (1, 2), (-1, 2), (-2, 1), (-2, -1), (-1, -2), (1, -2), (2, -1)]
        visited = [[False] * n for _ in range(n)]

        def dfs(x, y, step):
            if step == n * n:
                return True
            visited[x][y] = True
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < n and 0 <= ny < n and not visited[nx][ny] and grid[nx][ny] == step + 1:
                    if dfs(nx, ny, step + 1):
                        return True
            visited[x][y] = False
            return False

        for i in range(n):
            for j in range(n):
                if grid[i][j] == 1:
                    return dfs(i, j, 1)
        return False