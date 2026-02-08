class Solution:
    def guardWall(self, n: int, k: int, guards: List[int], walls: List[int]) -> List[int]:
        from collections import deque

        grid = [[0] * n for _ in range(n)]
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        for x, y in guards:
            grid[x][y] = 2

        for x, y in walls:
            grid[x][y] = 1

        q = deque()

        for i in range(n):
            for j in range(n):
                if grid[i][j] == 2:
                    q.append((i, j, 0))

        while q:
            x, y, dist = q.popleft()
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < n and 0 <= ny < n and grid[nx][ny] == 0:
                    grid[nx][ny] = dist + 1
                    q.append((nx, ny, dist + 1))

        result = []
        for i in range(n):
            for j in range(n):
                if grid[i][j] == 0:
                    result.append([i, j])

        return result