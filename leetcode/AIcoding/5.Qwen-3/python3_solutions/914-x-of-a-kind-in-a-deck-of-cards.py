from collections import Counter
import math

class Solution:
    def hasGroupsSizeX(self, deck: List[int]) -> bool:
        count = Counter(deck)
        min_freq = min(count.values())
        for i in range(2, min_freq + 1):
            if all(freq % i == 0 for freq in count.values()):
                return True
        return False