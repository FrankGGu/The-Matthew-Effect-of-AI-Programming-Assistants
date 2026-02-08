class Solution:
    def droneFlight(self, n: int, m: int, grid: List[List[int]]) -> int:
        from collections import deque

        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        def bfs(start_row, start_col):
            visited = [[False] * m for _ in range(n)]
            queue = deque([(start_row, start_col)])
            visited[start_row][start_col] = True
            count = 0
            while queue:
                r, c = queue.popleft()
                count += 1
                for dr, dc in directions:
                    nr, nc = r + dr, c + dc
                    if 0 <= nr < n and 0 <= nc < m and not visited[nr][nc] and grid[nr][nc] == grid[start_row][start_col]:
                        visited[nr][nc] = True
                        queue.append((nr, nc))
            return count

        max_size = 0
        visited = [[False] * m for _ in range(n)]
        for i in range(n):
            for j in range(m):
                if not visited[i][j]:
                    size = bfs(i, j)
                    max_size = max(max_size, size)
        return max_size