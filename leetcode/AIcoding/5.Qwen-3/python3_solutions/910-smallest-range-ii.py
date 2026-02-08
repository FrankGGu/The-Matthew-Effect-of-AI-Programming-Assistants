class Solution:
    def smallestRangeII(self, nums: List[int]) -> int:
        nums.sort()
        n = len(nums)
        min_range = float('inf')
        for i in range(1, n):
            min_val = min(nums[0], nums[i] - nums[0])
            max_val = max(nums[-1], nums[i] - nums[0])
            min_range = min(min_range, max_val - min_val)
        return min_range