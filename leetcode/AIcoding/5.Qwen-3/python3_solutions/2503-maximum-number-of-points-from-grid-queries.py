class Solution:
    def maxPoints(self, grid, queries, k):
        from collections import deque

        def bfs(i, j, visited, grid, k):
            q = deque()
            q.append((i, j))
            visited[i][j] = True
            points = 0
            while q:
                x, y = q.popleft()
                points += 1
                for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < len(grid) and 0 <= ny < len(grid[0]) and not visited[nx][ny] and grid[nx][ny] >= k:
                        visited[nx][ny] = True
                        q.append((nx, ny))
            return points

        rows, cols = len(grid), len(grid[0])
        res = []
        for q in queries:
            visited = [[False] * cols for _ in range(rows)]
            total = 0
            for i in range(rows):
                for j in range(cols):
                    if not visited[i][j] and grid[i][j] >= q:
                        total += bfs(i, j, visited, grid, q)
            res.append(total)
        return res