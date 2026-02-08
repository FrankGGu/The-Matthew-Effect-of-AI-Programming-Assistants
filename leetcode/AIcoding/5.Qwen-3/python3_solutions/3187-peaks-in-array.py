from typing import List

class Solution:
    def peaks(self, nums: List[int]) -> List[int]:
        result = []
        for i in range(1, len(nums) - 1):
            if nums[i] > nums[i - 1] and nums[i] > nums[i + 1]:
                result.append(i)
        return result