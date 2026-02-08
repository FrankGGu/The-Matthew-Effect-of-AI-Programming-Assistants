from typing import List
import functools

class Solution:
    def maxValueOfKCoins(self, piles: List[List[int]], k: int) -> int:
        @functools.lru_cache(None)
        def dp(i, remaining):
            if i == len(piles) or remaining == 0:
                return 0
            res = dp(i + 1, remaining)
            total = 0
            for j in range(min(len(piles[i]), remaining)):
                total += piles[i][j]
                res = max(res, total + dp(i + 1, remaining - j - 1))
            return res

        return dp(0, k)