from collections import Counter
from typing import List

class Solution:
    def countAlmostEqualPairs(self, nums: List[int]) -> int:
        def is_almost_equal(a, b):
            diff = 0
            for x, y in zip(a, b):
                if x != y:
                    diff += 1
                    if diff > 2:
                        return False
            return diff <= 2

        count = 0
        n = len(nums)
        for i in range(n):
            for j in range(i + 1, n):
                if is_almost_equal(str(nums[i]), str(nums[j])):
                    count += 1
        return count