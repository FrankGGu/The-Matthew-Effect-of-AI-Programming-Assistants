class Solution:
    def dominantIndex(self, nums: List[int]) -> int:
        max_val = max(nums)
        for num in nums:
            if num != max_val and max_val < 2 * num:
                return -1
        return nums.index(max_val)