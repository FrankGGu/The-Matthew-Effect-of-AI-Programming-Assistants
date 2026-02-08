class Solution:
    def minCost(self, walls: List[int], workers: List[int], cost: int) -> int:
        from functools import lru_cache

        walls.sort()
        workers.sort()

        @lru_cache(None)
        def dp(w_idx, w_idx2):
            if w_idx >= len(walls):
                return 0
            if w_idx2 >= len(workers):
                return float('inf')
            res = float('inf')
            for i in range(w_idx2, len(workers)):
                if walls[w_idx] < workers[i]:
                    res = min(res, cost + dp(w_idx + 1, i + 1))
            return res

        return dp(0, 0)