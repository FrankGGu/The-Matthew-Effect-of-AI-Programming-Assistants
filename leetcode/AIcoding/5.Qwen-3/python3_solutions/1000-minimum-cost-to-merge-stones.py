class Solution:
    def minCostToMergeStones(self, stones: List[int]) -> int:
        n = len(stones)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + stones[i]

        import functools
        @functools.lru_cache(None)
        def dp(i, j):
            if j - i + 1 == 1:
                return 0
            res = float('inf')
            for k in range(i, j):
                res = min(res, dp(i, k) + dp(k + 1, j))
            if (j - i) % 2 == 0:
                res = min(res, dp(i, j - 1) + prefix[j + 1] - prefix[i])
            return res

        return dp(0, n - 1)