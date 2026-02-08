class Solution:
    def minimumDifference(self, nums: List[int]) -> int:
        from functools import lru_cache

        total = sum(nums)
        n = len(nums)
        target = total // 2

        @lru_cache(None)
        def dp(i, cnt):
            if i == n:
                return 0 if cnt == n // 2 else float('inf')
            return min(dp(i + 1, cnt), dp(i + 1, cnt + 1) + nums[i])

        return abs(total - 2 * dp(0, 0))