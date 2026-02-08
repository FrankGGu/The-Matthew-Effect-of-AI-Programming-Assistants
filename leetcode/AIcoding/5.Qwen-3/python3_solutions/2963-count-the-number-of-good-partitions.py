class Solution:
    def countGoodPartitions(self, s: str) -> int:
        last = {}
        for i, c in enumerate(s):
            last[c] = i
        res = 0
        end = 0
        for i, c in enumerate(s):
            end = max(end, last[c])
            if i == end:
                res += 1
        return res