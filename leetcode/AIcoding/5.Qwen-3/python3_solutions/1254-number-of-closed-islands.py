class Solution:
    def closedIsland(self, grid: List[List[int]]) -> int:
        if not grid or not grid[0]:
            return 0

        rows, cols = len(grid), len(grid[0])
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        def dfs(r, c):
            if r < 0 or r >= rows or c < 0 or c >= cols:
                return False
            if grid[r][c] != 0:
                return True
            grid[r][c] = 2
            is_closed = True
            for dr, dc in directions:
                nr, nc = r + dr, c + dc
                if not dfs(nr, nc):
                    is_closed = False
            return is_closed

        count = 0
        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == 0 and dfs(r, c):
                    count += 1
        return count