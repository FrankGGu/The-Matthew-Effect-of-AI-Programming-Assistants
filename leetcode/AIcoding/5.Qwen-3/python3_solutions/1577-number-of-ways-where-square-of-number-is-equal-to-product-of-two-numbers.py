from collections import Counter
from typing import List

class Solution:
    def numTriplets(self, nums: List[int]) -> int:
        count = 0
        square_counts = Counter()
        for num in nums:
            square_counts[num * num] += 1
        for i in range(len(nums)):
            for j in range(i + 1, len(nums)):
                product = nums[i] * nums[j]
                count += square_counts.get(product, 0)
        return count