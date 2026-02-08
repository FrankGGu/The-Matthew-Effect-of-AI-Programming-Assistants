from collections import deque
from typing import List

class Solution:
    def updateMatrix(self, matrix: List[List[int]]) -> List[List[int]]:
        m, n = len(matrix), len(matrix[0])
        dist = [[0] * n for _ in range(m)]
        visited = [[False] * n for _ in range(m)]
        q = deque()

        for i in range(m):
            for j in range(n):
                if matrix[i][j] == 0:
                    q.append((i, j))
                    visited[i][j] = True

        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        while q:
            x, y = q.popleft()
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n and not visited[nx][ny]:
                    dist[nx][ny] = dist[x][y] + 1
                    visited[nx][ny] = True
                    q.append((nx, ny))

        return dist