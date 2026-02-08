class Solution:
    def findTheDifference(self, s: str, t: str) -> int:
        from collections import Counter
        return ord(list((Counter(t) - Counter(s)).keys())[0])