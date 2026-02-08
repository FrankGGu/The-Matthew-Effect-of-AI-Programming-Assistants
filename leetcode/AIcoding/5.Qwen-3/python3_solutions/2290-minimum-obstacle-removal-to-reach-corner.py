from collections import deque

class Solution:
    def minimumObstacleRemovalToReachCorner(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        queue = deque([(0, 0, 0)])
        visited = [[False] * n for _ in range(m)]
        visited[0][0] = True

        while queue:
            x, y, obstacles = queue.popleft()
            if x == m - 1 and y == n - 1:
                return obstacles
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n and not visited[nx][ny]:
                    visited[nx][ny] = True
                    if grid[nx][ny] == 1:
                        queue.append((nx, ny, obstacles + 1))
                    else:
                        queue.appendleft((nx, ny, obstacles))
        return -1