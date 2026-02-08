class Solution:
    def minFlips(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        def bfs(start, target):
            from collections import deque
            visited = [[False]*n for _ in range(m)]
            q = deque()
            q.append((start[0], start[1], 0))
            visited[start[0]][start[1]] = True
            while q:
                x, y, steps = q.popleft()
                if (x, y) == target:
                    return steps
                for dx, dy in dirs:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < m and 0 <= ny < n and not visited[nx][ny]:
                        visited[nx][ny] = True
                        q.append((nx, ny, steps + 1))
            return float('inf')

        def hasPath():
            for i in range(m):
                for j in range(n):
                    if grid[i][j] == 1:
                        for k in range(m):
                            for l in range(n):
                                if grid[k][l] == 0:
                                    return bfs((i, j), (k, l)) != float('inf')
            return False

        if not hasPath():
            return 0

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 1:
                    grid[i][j] = 0
                    if not hasPath():
                        return 1
                    grid[i][j] = 1
        return 2