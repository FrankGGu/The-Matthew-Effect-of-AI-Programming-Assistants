class Solution:
    def guardCastle(self, grid: List[List[str]]) -> int:
        from collections import deque

        m, n = len(grid), len(grid[0])
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1), (-1, -1), (-1, 1), (1, -1), (1, 1)]

        def is_valid(x, y):
            return 0 <= x < m and 0 <= y < n

        def bfs(start_x, start_y):
            visited = [[False] * n for _ in range(m)]
            queue = deque([(start_x, start_y)])
            visited[start_x][start_y] = True
            count = 0
            while queue:
                x, y = queue.popleft()
                count += 1
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if is_valid(nx, ny) and not visited[nx][ny] and grid[nx][ny] == '0':
                        visited[nx][ny] = True
                        queue.append((nx, ny))
            return count

        max_area = 0
        for i in range(m):
            for j in range(n):
                if grid[i][j] == '0':
                    max_area = max(max_area, bfs(i, j))
        return max_area