from collections import Counter
from typing import List

class Solution:
    def findLeastNumOfUniqueInts(self, arr: List[int], k: int) -> int:
        count = Counter(arr)
        freq = list(count.values())
        freq.sort()
        for i in range(len(freq)):
            if k >= freq[i]:
                k -= freq[i]
                freq[i] = 0
            else:
                break
        return len([x for x in freq if x > 0])