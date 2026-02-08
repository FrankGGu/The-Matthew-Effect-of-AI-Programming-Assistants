class Solution:
    def getLengthOfOptimalCompression(self, s: str, k: int) -> int:
        from functools import lru_cache

        @lru_cache(None)
        def dp(i, prev, count, deletes):
            if deletes > k:
                return float('inf')
            if i == len(s):
                return 0
            res = dp(i + 1, prev, count, deletes + 1)
            if s[i] == prev:
                add = 1 if count in (1, 9, 99) else 0
                res = min(res, add + dp(i + 1, prev, count + 1, deletes))
            else:
                res = min(res, 1 + dp(i + 1, s[i], 1, deletes))
            return res

        return dp(0, '', 0, 0)