class Solution:
    def detectValidString(self, s: str) -> bool:
        from functools import lru_cache

        @lru_cache(None)
        def dfs(i, left):
            if i == len(s):
                return left == 0
            if s[i] == '(':
                return dfs(i + 1, left + 1)
            elif s[i] == ')':
                return left > 0 and dfs(i + 1, left - 1)
            else:
                return dfs(i + 1, left + 1) or (left > 0 and dfs(i + 1, left - 1))

        return dfs(0, 0)