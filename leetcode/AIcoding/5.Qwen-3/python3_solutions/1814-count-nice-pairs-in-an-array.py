from collections import defaultdict
from typing import List

class Solution:
    def countNicePairs(self, nums: List[int]) -> int:
        def reverseNum(x):
            return int(str(x)[::-1])

        count = defaultdict(int)
        res = 0
        for num in nums:
            rev = reverseNum(num)
            res += count[rev]
            count[rev] += 1
        return res