class NeighborSumService:
    def __init__(self, grid: List[List[int]]):
        self.grid = grid
        self.rows = len(grid)
        self.cols = len(grid[0]) if self.rows > 0 else 0
        self.value_to_position = {}
        for i in range(self.rows):
            for j in range(self.cols):
                self.value_to_position[grid[i][j]] = (i, j)

    def adjacentSum(self, value: int) -> int:
        i, j = self.value_to_position.get(value, (-1, -1))
        if i == -1:
            return 0
        total = 0
        if i > 0:
            total += self.grid[i-1][j]
        if i < self.rows - 1:
            total += self.grid[i+1][j]
        if j > 0:
            total += self.grid[i][j-1]
        if j < self.cols - 1:
            total += self.grid[i][j+1]
        return total