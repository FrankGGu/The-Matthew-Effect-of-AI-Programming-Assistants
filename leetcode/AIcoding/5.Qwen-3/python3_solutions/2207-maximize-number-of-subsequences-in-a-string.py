class Solution:
    def maximumSubsequenceCount(self, s: str, k: int) -> int:
        from collections import Counter

        count = Counter(s)
        res = 0
        for c in count:
            res += count[c] * (count[c] - 1) // 2
        return res