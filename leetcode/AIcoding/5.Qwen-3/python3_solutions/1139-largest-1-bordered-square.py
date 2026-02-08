class Solution:
    def largest1BorderedSquare(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        max_len = 0
        for i in range(m):
            for j in range(n):
                if grid[i][j] == 1:
                    side = 1
                    while i + side < m and j + side < n:
                        if grid[i][j + side] == 1 and grid[i + side][j] == 1:
                            valid = True
                            for k in range(1, side):
                                if grid[i + k][j + side] != 1 or grid[i + side][j + k] != 1:
                                    valid = False
                                    break
                            if valid:
                                side += 1
                            else:
                                break
                        else:
                            break
                    max_len = max(max_len, side)
        return max_len * max_len