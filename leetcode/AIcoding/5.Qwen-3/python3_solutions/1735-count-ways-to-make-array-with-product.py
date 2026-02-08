class Solution:
    def numberOfWays(self, n: int, x: int) -> int:
        from math import isqrt

        def count_ways(n, x):
            if x == 1:
                return n
            res = 0
            for i in range(1, isqrt(n) + 1):
                if pow(i, x) > n:
                    break
                if n % pow(i, x) == 0:
                    j = n // pow(i, x)
                    if i == j:
                        res += 1
                    else:
                        res += 2
            return res

        return count_ways(n, x)