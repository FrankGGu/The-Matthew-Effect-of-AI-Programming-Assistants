class Solution:
    def maximumGridGain(self, m: int, n: int, x: int, y: int) -> int:
        def dfs(i, j, a, b):
            if i == m:
                return 0
            if j == n:
                return dfs(i + 1, 0, a, b)
            key = (i, j, a, b)
            if key in memo:
                return memo[key]
            res = dfs(i, j + 1, a, b)
            if a > 0:
                res = max(res, y + dfs(i, j + 1, a - 1, b))
            if b > 0:
                res = max(res, x + dfs(i, j + 1, a, b - 1))
            memo[key] = res
            return res

        memo = {}
        return dfs(0, 0, x, y)