class Solution:
    def isGridCutable(self, grid: List[List[int]]) -> bool:
        from collections import deque

        def bfs(start_row, start_col):
            visited = [[False] * len(grid[0]) for _ in range(len(grid))]
            queue = deque([(start_row, start_col)])
            visited[start_row][start_col] = True
            count = 0
            while queue:
                r, c = queue.popleft()
                count += 1
                for dr, dc in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                    nr, nc = r + dr, c + dc
                    if 0 <= nr < len(grid) and 0 <= nc < len(grid[0]) and not visited[nr][nc] and grid[nr][nc] == 1:
                        visited[nr][nc] = True
                        queue.append((nr, nc))
            return count

        rows, cols = len(grid), len(grid[0])
        total = sum(cell for row in grid for cell in row)
        if total % 4 != 0:
            return False

        for i in range(rows):
            for j in range(cols):
                if grid[i][j] == 1:
                    size = bfs(i, j)
                    if size != total // 4:
                        return False
        return True