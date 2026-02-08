class Solution:
    def minDominoRotations(self, rows: List[int]) -> int:
        from collections import Counter

        n = len(rows)
        count = [0] * 2
        same = [0] * 2

        for i in range(n):
            a, b = rows[i]
            if a == b:
                same[a - 1] += 1
            else:
                count[a - 1] += 1
                count[b - 1] += 1

        for i in range(2):
            if count[i] + same[i] == n:
                return n - max(count[i], same[i])

        return -1