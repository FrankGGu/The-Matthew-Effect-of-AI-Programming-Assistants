class Solution:
    def minOperations(self, nums: List[int]) -> int:
        n = len(nums)
        nums = sorted(set(nums))
        m = len(nums)
        res = n
        for i in range(m):
            j = i
            while j < m and nums[j] - nums[i] <= n - 1:
                j += 1
            res = min(res, n - (j - i))
        return res