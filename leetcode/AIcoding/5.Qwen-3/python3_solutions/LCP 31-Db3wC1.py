class Solution:
    def hasPath(self, maze: List[List[int]], start: List[int], destination: List[int]) -> bool:
        from collections import deque

        m, n = len(maze), len(maze[0])
        visited = [[False] * n for _ in range(m)]
        queue = deque()
        queue.append((start[0], start[1]))
        visited[start[0]][start[1]] = True

        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        while queue:
            x, y = queue.popleft()
            if [x, y] == destination:
                return True
            for dx, dy in directions:
                nx, ny = x, y
                while 0 <= nx + dx < m and 0 <= ny + dy < n and maze[nx + dx][ny + dy] == 0:
                    nx += dx
                    ny += dy
                if not visited[nx][ny]:
                    visited[nx][ny] = True
                    queue.append((nx, ny))
        return False