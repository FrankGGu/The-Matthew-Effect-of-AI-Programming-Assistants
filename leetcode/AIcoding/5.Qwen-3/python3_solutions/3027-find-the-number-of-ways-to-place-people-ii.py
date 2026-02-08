class Solution:
    def numberOfWays(self, n: int, m: int, x: int, y: int) -> int:
        MOD = 10**9 + 7
        from math import comb

        def count_ways(a, b):
            return comb(a, 2) * comb(b, 2)

        total = 0
        for i in range(n):
            for j in range(m):
                if i == x and j == y:
                    continue
                total += count_ways(i, j)
                total %= MOD
        return total