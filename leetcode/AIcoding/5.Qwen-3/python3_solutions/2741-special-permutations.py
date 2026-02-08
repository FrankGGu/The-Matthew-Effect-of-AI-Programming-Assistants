from typing import List

class Solution:
    def specialPermutations(self, nums: List[int]) -> int:
        n = len(nums)
        from functools import lru_cache

        @lru_cache(None)
        def dp(mask, last):
            if mask == (1 << n) - 1:
                return 1
            res = 0
            for i in range(n):
                if not (mask & (1 << i)) and (last == -1 or nums[i] % nums[last] == 0):
                    res += dp(mask | (1 << i), i)
            return res

        return dp(0, -1)