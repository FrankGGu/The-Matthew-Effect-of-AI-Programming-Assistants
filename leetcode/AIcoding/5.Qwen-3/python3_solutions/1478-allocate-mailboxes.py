class Solution:
    def minCost(self, houses: list[int], cost: list[int], m: int, n: int, k: int) -> int:
        import sys
        sys.setrecursionlimit(10000)
        from functools import lru_cache

        @lru_cache(None)
        def dp(i, j, c):
            if j == 0:
                return float('inf') if i != m else 0
            if i == m:
                return float('inf') if j != 0 else 0
            res = float('inf')
            color = houses[i]
            for l in range(i, m):
                if l > i:
                    if houses[l] == color:
                        continue
                    else:
                        color = houses[l]
                if l < m - 1:
                    res = min(res, dp(l + 1, j - 1, color) + cost[i][color - 1])
                else:
                    res = min(res, dp(l + 1, j - 1, color))
            return res

        result = dp(0, k, -1)
        return result if result != float('inf') else -1