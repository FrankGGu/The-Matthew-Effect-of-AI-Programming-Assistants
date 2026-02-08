class Solution:
    def minDays(self, grid: List[List[int]]) -> int:
        from collections import deque

        def count_islands():
            visited = [[False for _ in range(len(grid[0]))] for _ in range(len(grid))]
            count = 0
            for i in range(len(grid)):
                for j in range(len(grid[0])):
                    if grid[i][j] == 1 and not visited[i][j]:
                        queue = deque()
                        queue.append((i, j))
                        visited[i][j] = True
                        while queue:
                            x, y = queue.popleft()
                            for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                                nx, ny = x + dx, y + dy
                                if 0 <= nx < len(grid) and 0 <= ny < len(grid[0]) and grid[nx][ny] == 1 and not visited[nx][ny]:
                                    visited[nx][ny] = True
                                    queue.append((nx, ny))
                        count += 1
            return count

        if count_islands() != 1:
            return 0

        for i in range(len(grid)):
            for j in range(len(grid[0])):
                if grid[i][j] == 1:
                    grid[i][j] = 0
                    if count_islands() != 1:
                        return 1
                    grid[i][j] = 1

        return 2