class Solution:
    def maxAdjacentDifference(self, nums: List[int]) -> int:
        n = len(nums)
        if n < 2:
            return 0
        max_diff = 0
        for i in range(n):
            diff = abs(nums[i] - nums[(i + 1) % n])
            if diff > max_diff:
                max_diff = diff
        return max_diff