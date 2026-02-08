from typing import List
from collections import deque

class Solution:
    def colorBorder(self, grid: List[List[int]], x: int, y: int, color: int) -> List[List[int]]:
        rows, cols = len(grid), len(grid[0])
        original_color = grid[x][y]
        visited = [[False for _ in range(cols)] for _ in range(rows)]
        queue = deque()
        queue.append((x, y))
        visited[x][y] = True
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        borders = []

        while queue:
            r, c = queue.popleft()
            count = 0
            for dr, dc in directions:
                nr, nc = r + dr, c + dc
                if 0 <= nr < rows and 0 <= nc < cols and grid[nr][nc] == original_color:
                    count += 1
                    if not visited[nr][nc]:
                        visited[nr][nc] = True
                        queue.append((nr, nc))
            if count < 4:
                borders.append((r, c))

        for r, c in borders:
            grid[r][c] = color

        return grid