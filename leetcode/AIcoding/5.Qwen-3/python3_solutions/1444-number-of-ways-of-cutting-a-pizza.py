class Solution:
    def ways(self, pizza: List[str]) -> int:
        from functools import lru_cache

        m = len(pizza)
        n = len(pizza[0])
        MOD = 10**9 + 7

        # Precompute the number of apples in the submatrix (i, j) to (m-1, n-1)
        pre = [[0] * (n + 1) for _ in range(m + 1)]
        for i in range(m - 1, -1, -1):
            for j in range(n - 1, -1, -1):
                pre[i][j] = (pizza[i][j] == 'A') + pre[i + 1][j] + pre[i][j + 1] - pre[i + 1][j + 1]

        @lru_cache(None)
        def dp(i, j, k):
            if k == 0:
                return 1
            res = 0
            for x in range(i, m):
                if pre[x][j] - pre[m][j] - pre[x][n] + pre[m][n] > 0:
                    res += dp(x + 1, j, k - 1)
                    res %= MOD
            for y in range(j, n):
                if pre[i][y] - pre[m][y] - pre[i][n] + pre[m][n] > 0:
                    res += dp(i, y + 1, k - 1)
                    res %= MOD
            return res

        return dp(0, 0, m + n - 2)