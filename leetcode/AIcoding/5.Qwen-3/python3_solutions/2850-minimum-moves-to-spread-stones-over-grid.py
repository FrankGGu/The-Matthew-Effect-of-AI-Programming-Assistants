class Solution:
    def minimumMoves(self, grid: List[List[int]]) -> int:
        from collections import deque

        n = len(grid)
        positions = []

        for i in range(n):
            for j in range(n):
                if grid[i][j] > 1:
                    for _ in range(grid[i][j] - 1):
                        positions.append((i, j))
                elif grid[i][j] == 1:
                    positions.append((i, j))

        target = [(i, j) for i in range(n) for j in range(n) if grid[i][j] == 0]

        def bfs(start, end):
            visited = [[False] * n for _ in range(n)]
            queue = deque([(start[0], start[1], 0)])
            visited[start[0]][start[1]] = True

            while queue:
                x, y, steps = queue.popleft()
                if (x, y) == end:
                    return steps
                for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < n and 0 <= ny < n and not visited[nx][ny]:
                        visited[nx][ny] = True
                        queue.append((nx, ny, steps + 1))

        total_moves = 0
        for i in range(len(positions)):
            total_moves += bfs(positions[i], target[i])

        return total_moves