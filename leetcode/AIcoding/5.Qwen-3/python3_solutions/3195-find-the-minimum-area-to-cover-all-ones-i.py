class Solution:
    def minimumArea(self, grid: List[List[int]]) -> int:
        rows = set()
        cols = set()
        for i in range(len(grid)):
            for j in range(len(grid[0])):
                if grid[i][j] == 1:
                    rows.add(i)
                    cols.add(j)
        return (max(rows) - min(rows)) * (max(cols) - min(cols))