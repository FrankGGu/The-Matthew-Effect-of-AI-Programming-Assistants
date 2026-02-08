class Solution:
    def checkAlmostEqual(self, s: str, t: str) -> bool:
        from collections import Counter
        return Counter(s) == Counter(t)