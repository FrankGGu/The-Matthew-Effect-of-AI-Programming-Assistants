class Solution:
    def maximumTripletValue(self, nums: List[int]) -> int:
        n = len(nums)
        maxRight = [0] * n
        maxRight[-1] = nums[-1]
        for i in range(n - 2, -1, -1):
            maxRight[i] = max(nums[i], maxRight[i + 1])
        res = 0
        for j in range(n):
            for i in range(j):
                if nums[i] > nums[j]:
                    res = max(res, nums[i] - nums[j] + maxRight[j + 1])
        return res