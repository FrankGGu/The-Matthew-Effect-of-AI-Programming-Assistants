class Solution:
    def minimumSum(self, nums: List[int]) -> int:
        n = len(nums)
        res = float('inf')
        for i in range(1, n - 1):
            left = min(nums[:i])
            right = min(nums[i + 1:])
            if left < nums[i] and nums[i] > right:
                res = min(res, left + nums[i] + right)
        return res if res != float('inf') else -1