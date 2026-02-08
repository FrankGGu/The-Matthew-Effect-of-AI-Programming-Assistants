class Solution:
    def canIWin(self, maxChoosableInteger: int, desiredTotal: int) -> bool:
        from functools import lru_cache

        @lru_cache(None)
        def dfs(used, current_total):
            for i in range(1, maxChoosableInteger + 1):
                if not (used & (1 << (i - 1))):
                    if current_total + i >= desiredTotal:
                        return True
                    if not dfs(used | (1 << (i - 1)), current_total + i):
                        return True
            return False

        return dfs(0, 0)