class Solution:
    def maxFish(self, grid: List[List[int]]) -> int:
        from collections import deque

        if not grid or not grid[0]:
            return 0

        rows, cols = len(grid), len(grid[0])
        visited = [[False for _ in range(cols)] for _ in range(rows)]
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        max_fish = 0

        def bfs(r, c):
            queue = deque()
            queue.append((r, c))
            visited[r][c] = True
            total = grid[r][c]

            while queue:
                x, y = queue.popleft()
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < rows and 0 <= ny < cols and not visited[nx][ny] and grid[nx][ny] > 0:
                        visited[nx][ny] = True
                        total += grid[nx][ny]
                        queue.append((nx, ny))
            return total

        for i in range(rows):
            for j in range(cols):
                if not visited[i][j] and grid[i][j] > 0:
                    max_fish = max(max_fish, bfs(i, j))

        return max_fish