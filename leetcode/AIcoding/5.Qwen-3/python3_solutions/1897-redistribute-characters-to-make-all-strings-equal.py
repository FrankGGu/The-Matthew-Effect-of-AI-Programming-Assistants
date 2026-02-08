from collections import Counter
from typing import List

class Solution:
    def makeEqual(self, words: List[str]) -> bool:
        cnt = Counter()
        for word in words:
            cnt += Counter(word)
        for v in cnt.values():
            if v % len(words) != 0:
                return False
        return True