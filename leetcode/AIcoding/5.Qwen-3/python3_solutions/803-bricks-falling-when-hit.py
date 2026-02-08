class Solution:
    def __init__(self):
        self.dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)]

    def hitBricks(self, grid: List[List[int]], hits: List[List[int]]) -> List[int]:
        m, n = len(grid), len(grid[0])
        for x, y in hits:
            grid[x][y] -= 1

        def dfs(x, y, visited):
            if x < 0 or x >= m or y < 0 or y >= n or grid[x][y] != 1 or (x, y) in visited:
                return 0
            visited.add((x, y))
            res = 1
            for dx, dy in self.dirs:
                res += dfs(x + dx, y + dy, visited)
            return res

        res = []
        for x, y in hits:
            if grid[x][y] == 0:
                res.append(0)
                continue
            grid[x][y] = 0
            visited = set()
            count = 0
            for dx, dy in self.dirs:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n and grid[nx][ny] == 1:
                    count += dfs(nx, ny, visited)
            res.append(count)
            grid[x][y] = 1

        return res