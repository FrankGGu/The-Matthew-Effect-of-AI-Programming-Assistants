class Solution:
    def countCells(self, rows: int, cols: int) -> int:
        return (rows * (rows + 1)) // 2 + (cols * (cols + 1)) // 2 - 1