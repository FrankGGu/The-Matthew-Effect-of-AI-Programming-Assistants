class Solution:
    def minSum(self, nums: List[int]) -> int:
        n = len(nums)
        min_sum = float('inf')
        for i in range(1, n - 1):
            left = min(nums[:i])
            right = min(nums[i+1:])
            if left < nums[i] and nums[i] > right:
                min_sum = min(min_sum, left + nums[i] + right)
        return min_sum if min_sum != float('inf') else -1