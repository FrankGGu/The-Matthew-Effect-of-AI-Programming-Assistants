class Solution:
    def removeBoxes(self, boxes: List[int]) -> int:
        from functools import lru_cache

        @lru_cache(None)
        def dp(left, right, k):
            if left > right:
                return 0
            while right > left and boxes[right] == boxes[right - 1]:
                right -= 1
                k += 1
            res = dp(left, right - 1, 0) + k * k
            for i in range(left, right):
                if boxes[i] == boxes[right]:
                    res = max(res, dp(left, i, k + 1) + dp(i + 1, right - 1, 0))
            return res

        return dp(0, len(boxes) - 1, 0)