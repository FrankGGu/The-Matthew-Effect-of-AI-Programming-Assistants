class Solution:
    def compareStrings(self, s: str, t: str) -> bool:
        from collections import Counter

        def getMinFreq(s):
            count = Counter(s)
            return count[min(count)]

        return getMinFreq(s) <= getMinFreq(t)