class Solution:
    def countSubmatrices(self, grid: List[List[int]], k: int) -> int:
        m = len(grid)
        n = len(grid[0])
        prefix = [[0] * (n + 1) for _ in range(m + 1)]
        for i in range(m):
            for j in range(n):
                prefix[i + 1][j + 1] = grid[i][j] + prefix[i][j + 1] + prefix[i + 1][j] - prefix[i][j]
        count = 0
        for i in range(1, m + 1):
            for j in range(1, n + 1):
                for x in range(i):
                    for y in range(j):
                        if prefix[i][j] - prefix[x][j] - prefix[i][y] + prefix[x][y] < k:
                            count += 1
        return count