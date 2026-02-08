class Solution:
    def colorChange(self, matrix: List[List[int]]) -> int:
        from collections import deque

        if not matrix or not matrix[0]:
            return 0

        rows, cols = len(matrix), len(matrix[0])
        visited = [[False for _ in range(cols)] for _ in range(rows)]
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        count = 0

        def bfs(r, c, color):
            queue = deque()
            queue.append((r, c))
            visited[r][c] = True
            area = 1
            while queue:
                x, y = queue.popleft()
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < rows and 0 <= ny < cols and not visited[nx][ny] and matrix[nx][ny] == color:
                        visited[nx][ny] = True
                        queue.append((nx, ny))
                        area += 1
            return area

        for i in range(rows):
            for j in range(cols):
                if not visited[i][j]:
                    area = bfs(i, j, matrix[i][j])
                    if area >= 2:
                        count += 1

        return count