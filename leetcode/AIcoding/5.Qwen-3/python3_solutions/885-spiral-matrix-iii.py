class Solution:
    def spiralMatrixIII(self, m: int, n: int, k: int) -> List[List[int]]:
        res = []
        x, y = 0, 0
        dx, dy = 0, 1
        steps = 1
        for i in range(k):
            res.append([x, y])
            if i % 2 == 0:
                steps += 1
            for _ in range(steps):
                x += dx
                y += dy
                if 0 <= x < m and 0 <= y < n:
                    res.append([x, y])
            if dx == 0 and dy == 1:
                dx, dy = 1, 0
            elif dx == 1 and dy == 0:
                dx, dy = 0, -1
            elif dx == 0 and dy == -1:
                dx, dy = -1, 0
            else:
                dx, dy = 0, 1
        return res