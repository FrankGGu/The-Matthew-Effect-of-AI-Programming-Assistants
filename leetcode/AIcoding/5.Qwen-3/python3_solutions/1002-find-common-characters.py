from collections import Counter
from typing import List

class Solution:
    def commonChars(self, words: List[str]) -> List[str]:
        common = Counter(words[0])
        for word in words[1:]:
            current = Counter(word)
            for char in common:
                if char in current:
                    common[char] = min(common[char], current[char])
                else:
                    common[char] = 0
        result = []
        for char, count in common.items():
            result.extend([char] * count)
        return result