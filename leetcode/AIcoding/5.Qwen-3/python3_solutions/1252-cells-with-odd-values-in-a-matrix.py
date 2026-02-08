class Solution:
    def oddCells(self, n: int, m: int, indices: List[List[int]]) -> int:
        rows = [0] * n
        cols = [0] * m
        for r, c in indices:
            rows[r] += 1
            cols[c] += 1
        count = 0
        for i in range(n):
            for j in range(m):
                if (rows[i] + cols[j]) % 2 == 1:
                    count += 1
        return count