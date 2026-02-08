from collections import deque

class Solution:
    def shortestPathFindAllKeys(self, grid: list[str]) -> int:
        m, n = len(grid), len(grid[0])
        queue = deque()
        visited = set()
        key_count = 0
        for i in range(m):
            for j in range(n):
                if grid[i][j] == '@':
                    queue.append((i, j, 0))
                elif 'a' <= grid[i][j] <= 'f':
                    key_count += 1
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        target_mask = (1 << key_count) - 1
        while queue:
            x, y, mask = queue.popleft()
            if mask == target_mask:
                return 0
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n:
                    cell = grid[nx][ny]
                    if cell == '#':
                        continue
                    if 'A' <= cell <= 'F':
                        if not (mask & (1 << (ord(cell) - ord('A')))):
                            continue
                    new_mask = mask
                    if 'a' <= cell <= 'f':
                        new_mask |= (1 << (ord(cell) - ord('a')))
                    state = (nx, ny, new_mask)
                    if state not in visited:
                        visited.add(state)
                        queue.append((nx, ny, new_mask))
        return -1