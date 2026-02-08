from typing import List

class Solution:
    def largestOutiler(self, nums: List[int]) -> int:
        total = sum(nums)
        nums_set = set(nums)
        max_outlier = float('-inf')
        for num in nums:
            if (total - num) % (len(nums) - 1) == 0:
                candidate = (total - num) // (len(nums) - 1)
                if candidate in nums_set:
                    max_outlier = max(max_outlier, num)
        return max_outlier