class Solution:
    def shortestBridge(self, grid: List[List[int]]) -> int:
        from collections import deque

        n = len(grid)
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        def dfs(i, j):
            grid[i][j] = 2
            for dx, dy in directions:
                x, y = i + dx, j + dy
                if 0 <= x < n and 0 <= y < n and grid[x][y] == 1:
                    dfs(x, y)

        def bfs():
            q = deque()
            for i in range(n):
                for j in range(n):
                    if grid[i][j] == 2:
                        q.append((i, j))
            steps = 0
            while q:
                for _ in range(len(q)):
                    x, y = q.popleft()
                    for dx, dy in directions:
                        nx, ny = x + dx, y + dy
                        if 0 <= nx < n and 0 <= ny < n:
                            if grid[nx][ny] == 1:
                                return steps
                            if grid[nx][ny] == 0:
                                grid[nx][ny] = 2
                                q.append((nx, ny))
                steps += 1
            return -1

        for i in range(n):
            for j in range(n):
                if grid[i][j] == 1:
                    dfs(i, j)
                    return bfs()