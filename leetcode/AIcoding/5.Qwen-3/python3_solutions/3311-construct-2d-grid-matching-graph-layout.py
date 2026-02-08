class Solution:
    def construct2DGrid(self, rows: int, cols: int) -> List[List[int]]:
        grid = []
        for i in range(rows):
            row = []
            for j in range(cols):
                row.append(i * cols + j)
            grid.append(row)
        return grid