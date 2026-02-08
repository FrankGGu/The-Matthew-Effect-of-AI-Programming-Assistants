class Solution:
    def minTimeToVisitAllCells(self, grid: List[List[int]]) -> int:
        from collections import deque

        m, n = len(grid), len(grid[0])
        visited = [[False] * n for _ in range(m)]
        q = deque()

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 0:
                    q.append((i, j))
                    visited[i][j] = True

        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        time = 0

        while q:
            for _ in range(len(q)):
                x, y = q.popleft()
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < m and 0 <= ny < n and not visited[nx][ny] and grid[nx][ny] <= time + 1:
                        visited[nx][ny] = True
                        q.append((nx, ny))
            time += 1

        return time