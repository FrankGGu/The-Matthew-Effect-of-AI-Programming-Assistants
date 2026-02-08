class Solution:
    def possibleToStamp(self, grid: List[List[int]]) -> bool:
        m, n = len(grid), len(grid[0])
        temp = [[0] * (n + 1) for _ in range(m + 1)]

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 1:
                    temp[i][j] += 1
                    temp[i][j + 1] -= 1
                    temp[i + 1][j] -= 1
                    temp[i + 1][j + 1] += 1

        for i in range(m):
            for j in range(n):
                temp[i + 1][j + 1] += temp[i][j + 1] + temp[i + 1][j] - temp[i][j]

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 1 and temp[i][j] == 0:
                    return False

        return True