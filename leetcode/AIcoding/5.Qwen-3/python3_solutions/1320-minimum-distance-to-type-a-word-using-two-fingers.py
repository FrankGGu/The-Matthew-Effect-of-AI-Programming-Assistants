class Solution:
    def minimumDistance(self, word: str) -> int:
        from functools import lru_cache

        def get_pos(c):
            return ord(c) - ord('a')

        def distance(a, b):
            x1, y1 = divmod(a, 6)
            x2, y2 = divmod(b, 6)
            return abs(x1 - x2) + abs(y1 - y2)

        @lru_cache(None)
        def dp(i, left, right):
            if i == len(word):
                return 0
            curr = get_pos(word[i])
            cost_left = distance(left, curr) + dp(i + 1, curr, right)
            cost_right = distance(right, curr) + dp(i + 1, left, curr)
            return min(cost_left, cost_right)

        return dp(0, 26, 26)