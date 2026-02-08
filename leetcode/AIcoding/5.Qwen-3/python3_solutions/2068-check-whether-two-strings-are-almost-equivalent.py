from collections import Counter

class Solution:
    def checkAlmostEquivalent(self, word1: str, word2: str) -> bool:
        count1 = Counter(word1)
        count2 = Counter(word2)
        for char in count1:
            if abs(count1[char] - count2.get(char, 0)) > 3:
                return False
        for char in count2:
            if abs(count2[char] - count1.get(char, 0)) > 3:
                return False
        return True