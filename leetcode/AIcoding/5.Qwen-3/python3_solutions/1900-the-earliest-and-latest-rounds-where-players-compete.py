class Solution:
    def earliestAndLatest(self, n: int, firstPlayer: int, secondPlayer: int) -> List[int]:
        from functools import lru_cache

        @lru_cache(None)
        def dp(a, b):
            if a > b:
                a, b = b, a
            if a == b:
                return [1, 1]
            res = [float('inf'), -1]
            for i in range(1, n + 1):
                if i == a or i == b:
                    continue
                if i < a:
                    left = dp(i, a)
                    right = dp(b, n)
                elif i > a and i < b:
                    left = dp(a, i)
                    right = dp(i, b)
                else:
                    left = dp(a, b)
                    right = dp(i, n)
                if left[0] == float('inf'):
                    continue
                if right[0] == float('inf'):
                    continue
                min_round = min(left[0], right[0]) + 1
                max_round = max(left[1], right[1]) + 1
                res[0] = min(res[0], min_round)
                res[1] = max(res[1], max_round)
            return res

        return dp(firstPlayer, secondPlayer)