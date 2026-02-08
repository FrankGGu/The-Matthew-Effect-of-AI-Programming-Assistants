class Solution:
    def numberOfInfectionSequences(self, n: int, k: int) -> int:
        from functools import lru_cache

        @lru_cache(None)
        def dp(i, j):
            if i == 0:
                return 1
            if j == 0:
                return 0
            return (dp(i - 1, j) * j + dp(i - 1, j - 1)) % (10**9 + 7)

        return dp(n, k)