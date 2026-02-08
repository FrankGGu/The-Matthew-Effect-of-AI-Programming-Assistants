class Solution:
    def minNumber(self, nums: list[int]) -> int:
        nums.sort()
        res = 0
        for i in range(0, len(nums), 2):
            res = res * 100 + nums[i] * 10 + nums[i + 1]
        return res