class Solution:
    def countCompleteDayPairs(self, s: str) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        res = 0
        for c in s:
            count[c] += 1
        for v in count.values():
            res += v * (v - 1) // 2
        return res