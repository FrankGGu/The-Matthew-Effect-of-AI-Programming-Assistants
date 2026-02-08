class Solution:
    def findSquare(self, grid: List[List[int]]) -> int:
        n = len(grid)
        for i in range(n):
            for j in range(n):
                if grid[i][j] == 1:
                    for k in range(1, min(n - i, n - j)):
                        if all(grid[i + a][j + b] == 1 for a in range(k + 1) for b in range(k + 1)):
                            return k * k
        return 0