from typing import List

class Solution:
    def subsetXORs(self, nums: List[int]) -> int:
        def backtrack(start, current):
            if start == len(nums):
                return current
            return backtrack(start + 1, current) ^ backtrack(start + 1, current ^ nums[start])

        return backtrack(0, 0)