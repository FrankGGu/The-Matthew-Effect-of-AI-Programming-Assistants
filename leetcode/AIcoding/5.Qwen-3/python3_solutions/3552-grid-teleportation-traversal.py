class Solution:
    def minTimeToTravel(self, grid: List[List[int]]) -> int:
        from collections import deque

        rows, cols = len(grid), len(grid[0])
        visited = [[False] * cols for _ in range(rows)]
        queue = deque()
        queue.append((0, 0, 0))
        visited[0][0] = True

        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        while queue:
            r, c, time = queue.popleft()
            if r == rows - 1 and c == cols - 1:
                return time
            for dr, dc in directions:
                nr, nc = r + dr, c + dc
                if 0 <= nr < rows and 0 <= nc < cols and not visited[nr][nc]:
                    visited[nr][nc] = True
                    queue.append((nr, nc, time + 1))
            if grid[r][c] == 1:
                for i in range(rows):
                    for j in range(cols):
                        if not visited[i][j]:
                            visited[i][j] = True
                            queue.append((i, j, time + 1))
        return -1