class Solution:
    def minimizeSum(self, nums: List[int]) -> int:
        nums.sort()
        n = len(nums)
        if n <= 3:
            return 0
        return min(nums[-3] - nums[0], nums[-2] - nums[1], nums[-1] - nums[2])