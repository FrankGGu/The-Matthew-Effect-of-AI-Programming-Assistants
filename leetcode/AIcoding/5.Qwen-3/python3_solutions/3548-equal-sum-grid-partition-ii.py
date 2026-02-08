class Solution:
    def gridGame(self, grid: List[List[int]]) -> int:
        n = len(grid)
        top = sum(grid[0][1:])
        bottom = 0
        res = float('inf')
        for i in range(n):
            top -= grid[0][i]
            res = min(res, max(top, bottom))
            bottom += grid[1][i]
        return res