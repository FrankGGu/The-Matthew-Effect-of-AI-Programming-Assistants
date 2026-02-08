class Solution:
    def minOperations(self, grid: List[List[int]]) from typing import List
    def minOperations(self, grid: List[List[int]]) -> int:
        rows = len(grid)
        cols = len(grid[0])
        operations = 0

        for j in range(1, cols):
            for i in range(rows):
                if grid[i][j] <= grid[i-1][j-1]:
                    operations += grid[i-1][j-1] - grid[i][j] + 1
                    grid[i][j] += grid[i-1][j-1] - grid[i][j] + 1
        return operations