from collections import Counter
from typing import List

class Solution:
    def findLonely(self, nums: List[int]) -> List[int]:
        count = Counter(nums)
        result = []
        for num in nums:
            if count[num] == 1 and (num - 1 not in count or count[num - 1] == 0) and (num + 1 not in count or count[num + 1] == 0):
                result.append(num)
        return result