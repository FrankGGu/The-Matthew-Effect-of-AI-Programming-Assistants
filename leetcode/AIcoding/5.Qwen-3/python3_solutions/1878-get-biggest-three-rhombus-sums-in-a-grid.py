class Solution:
    def getBiggestThree(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        res = set()

        for i in range(m):
            for j in range(n):
                res.add(grid[i][j])

        for k in range(1, min(m, n)):
            for i in range(k, m - k):
                for j in range(k, n - k):
                    total = 0
                    for d in range(k):
                        total += grid[i - d][j + d]
                        total += grid[i + d][j + d]
                        total += grid[i + d][j - d]
                        total += grid[i - d][j - d]
                    total -= grid[i][j]
                    res.add(total)

        return max(res)