class Solution:
    def hasValidPath(self, grid: List[List[int]]) -> bool:
        from collections import deque

        directions = {
            1: [(0, 1), (0, -1)],
            2: [(1, 0), (-1, 0)],
            3: [(0, 1), (1, 0)],
            4: [(0, 1), (-1, 0)],
            5: [(0, -1), (1, 0)],
            6: [(0, -1), (-1, 0)]
        }

        visited = set()
        queue = deque()

        queue.append((0, 0))
        visited.add((0, 0))

        while queue:
            x, y = queue.popleft()
            if x == len(grid) - 1 and y == len(grid[0]) - 1:
                return True
            for dx, dy in directions[grid[x][y]]:
                nx, ny = x + dx, y + dy
                if 0 <= nx < len(grid) and 0 <= ny < len(grid[0]) and (nx, ny) not in visited:
                    if (dx, dy) in directions[grid[nx][ny]]:
                        visited.add((nx, ny))
                        queue.append((nx, ny))
        return False