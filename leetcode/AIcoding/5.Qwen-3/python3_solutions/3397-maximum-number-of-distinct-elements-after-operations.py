from collections import Counter
from typing import List

class Solution:
    def maximumNumberOfDistinctElements(self, nums: List[int], k: int) -> int:
        count = Counter(nums)
        freq = list(count.values())
        freq.sort()

        res = 0
        for f in freq:
            if f <= k:
                res += 1
            else:
                res += 1
                k -= 1
            if k < 0:
                break
        return res