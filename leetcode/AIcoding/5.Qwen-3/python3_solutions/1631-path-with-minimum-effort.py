from collections import deque

class Solution:
    def findMinimumEffortPath(self, heights) -> int:
        rows, cols = len(heights), len(heights[0])
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        min_effort = [[float('inf')] * cols for _ in range(rows)]
        min_effort[0][0] = 0
        queue = deque([(0, 0)])

        while queue:
            r, c = queue.popleft()
            for dr, dc in directions:
                nr, nc = r + dr, c + dc
                if 0 <= nr < rows and 0 <= nc < cols:
                    new_effort = max(min_effort[r][c], abs(heights[nr][nc] - heights[r][c]))
                    if new_effort < min_effort[nr][nc]:
                        min_effort[nr][nc] = new_effort
                        queue.append((nr, nc))

        return min_effort[rows-1][cols-1]