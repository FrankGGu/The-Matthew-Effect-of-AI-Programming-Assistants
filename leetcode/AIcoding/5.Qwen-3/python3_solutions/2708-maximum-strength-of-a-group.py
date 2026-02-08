class Solution:
    def maxStrength(self, nums: List[int]) -> int:
        if len(nums) == 1:
            return nums[0]
        nums.sort()
        return max(nums[-1] * nums[-2], nums[0] * nums[1])