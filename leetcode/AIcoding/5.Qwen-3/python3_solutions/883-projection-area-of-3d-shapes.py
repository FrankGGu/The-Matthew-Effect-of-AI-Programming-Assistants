class Solution:
    def projectionArea(self, grid: List[List[int]]) -> int:
        xy = sum(1 for row in grid for val in row if val > 0)
        xz = sum(max(row) for row in grid)
        yz = sum(max(grid[i][j] for i in range(len(grid))) for j in range(len(grid[0])))
        return xy + xz + yz