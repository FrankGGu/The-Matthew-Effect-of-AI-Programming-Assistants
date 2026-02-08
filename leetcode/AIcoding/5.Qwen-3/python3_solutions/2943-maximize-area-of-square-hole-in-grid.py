class Solution:
    def maximizeSquareHoleArea(self, grid: List[List[int]]) -> int:
        rows = len(grid)
        cols = len(grid[0]) if rows > 0 else 0
        max_side = 0

        for i in range(rows):
            for j in range(cols):
                if grid[i][j] == 1:
                    continue
                side = 1
                while i + side < rows and j + side < cols and grid[i + side][j] == 0 and grid[i][j + side] == 0 and grid[i + side][j + side] == 0:
                    side += 1
                max_side = max(max_side, side)

        return max_side * max_side