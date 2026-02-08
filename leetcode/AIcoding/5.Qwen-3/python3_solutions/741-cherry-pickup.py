class Solution:
    def cherryPickup(self, grid: List[List[int]]) -> int:
        n = len(grid)
        from functools import lru_cache

        @lru_cache(None)
        def dp(r1, c1, r2, c2):
            if r1 >= n or c1 >= n or r2 >= n or c2 >= n:
                return -float('inf')
            if r1 == n - 1 and c1 == n - 1:
                return grid[r1][c1]
            if r2 == n - 1 and c2 == n - 1:
                return grid[r2][c2]
            res = grid[r1][c1]
            if r1 != r2 or c1 != c2:
                res += grid[r2][c2]
            max_cherries = 0
            for dr in [0, 1]:
                for dc in [0, 1]:
                    nr1, nc1 = r1 + dr, c1 + dc
                    nr2, nc2 = r2 + dr, c2 + dc
                    max_cherries = max(max_cherries, dp(nr1, nc1, nr2, nc2))
            return res + max_cherries

        return max(0, dp(0, 0, 0, 1))