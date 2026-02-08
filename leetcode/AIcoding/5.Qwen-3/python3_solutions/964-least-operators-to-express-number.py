class Solution:
    def leastOpsToExpressNumber(self, n: int) -> int:
        from functools import lru_cache

        @lru_cache(None)
        def dfs(x):
            if x == 1:
                return 0
            res = float('inf')
            i = 0
            while (2 ** i) <= x:
                i += 1
            for k in [i - 1, i]:
                if k == 0:
                    continue
                cost = 0
                if (2 ** k) > x:
                    cost += 1
                cost += dfs(x - (2 ** k))
                res = min(res, cost)
                if (2 ** k) < x:
                    cost = 1
                    cost += dfs((2 ** k) - x)
                    res = min(res, cost)
            return res

        return dfs(n)