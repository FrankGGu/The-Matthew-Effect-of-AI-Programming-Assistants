class Solution:
    def maximumValue(self, nums: List[int]) -> int:
        max_val = 0
        for num in nums:
            max_val = max(max_val, num)
        return max_val